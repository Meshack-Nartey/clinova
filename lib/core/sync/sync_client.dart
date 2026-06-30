import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../database/app_database.dart';
import '../auth/encryption.dart';
import 'hub_server.dart';
import 'sync_payload.dart';
import 'sync_providers.dart';

const _pollInterval = Duration(seconds: 5);
const _connectTimeout = Duration(seconds: 4);

class SyncClient {
  final AppDatabase _db;
  final String hubBaseUrl;
  final String sessionToken;
  final void Function(SyncStatus) onStatusChange;

  Timer? _timer;
  bool _running = false;

  SyncClient({
    required this._db,
    required this.hubBaseUrl,
    required this.sessionToken,
    required this.onStatusChange,
  });

  Future<void> start() async {
    _running = true;
    await _poll(); // immediate first poll
    _timer = Timer.periodic(_pollInterval, (_) async {
      if (_running) await _poll();
    });
  }

  Future<void> stop() async {
    _running = false;
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _poll() async {
    onStatusChange(SyncStatus.syncing);
    try {
      final deviceId = await getOrCreateDeviceId();
      final since = await _db.userDao.getLastSyncAt(deviceId);

      // Collect local changes since last sync
      final localPatients = await _db.patientDao.getPatientsSince(since);
      final localConsults = await _db.patientDao.getConsultationsSince(since);
      final localDispensing = await _db.patientDao.getDispensingRecordsSince(since);
      final localLab = await _db.patientDao.getLabResultsSince(since);

      final request = SyncRequest(
        deviceId: deviceId,
        sinceTimestamp: since,
        changes: [
          ...localPatients.map((p) => SyncChange(table: 'patients', payload: p.toSyncMap())),
          ...localConsults.map((c) => SyncChange(table: 'consultations', payload: c.toSyncMap())),
          ...localDispensing
              .map((d) => SyncChange(table: 'dispensing_records', payload: d.toSyncMap())),
          ...localLab.map((l) => SyncChange(table: 'lab_results', payload: l.toSyncMap())),
        ],
      );

      final response = await http
          .post(
            Uri.parse('$hubBaseUrl/sync'),
            headers: {
              'content-type': 'application/json',
              'authorization': 'Bearer $sessionToken',
            },
            body: jsonEncode(request.toJson()),
          )
          .timeout(_connectTimeout);

      if (response.statusCode != 200) {
        onStatusChange(SyncStatus.error);
        return;
      }

      final syncResponse =
          SyncResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

      // Apply incoming changes from hub
      for (final change in syncResponse.changes) {
        switch (change.table) {
          case 'patients':
            await _db.patientDao.mergeSyncedPatient(change.payload, 'hub');
          case 'consultations':
            await _db.patientDao.mergeSyncedConsultation(change.payload);
          case 'dispensing_records':
            await _db.patientDao.mergeSyncedDispensingRecord(change.payload);
          case 'lab_results':
            await _db.patientDao.mergeSyncedLabResult(change.payload);
        }
      }

      await _db.userDao.updateLastSyncAt(deviceId, syncResponse.serverTimestamp);
      onStatusChange(SyncStatus.live);
    } on TimeoutException {
      onStatusChange(SyncStatus.error);
    } catch (_) {
      onStatusChange(SyncStatus.error);
    }
  }
}
