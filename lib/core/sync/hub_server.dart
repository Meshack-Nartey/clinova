import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

import '../database/app_database.dart';
import '../database/tables.dart';
import 'sync_payload.dart';

const _hubPort = 8765;

/// Embedded HTTP sync hub that runs on the doctor's laptop.
/// Clients POST to /sync; the hub merges their changes and returns its own.
class HubServer {
  final AppDatabase _db;
  HttpServer? _server;

  HubServer(this._db);

  Future<void> start() async {
    final router = Router()
      ..get('/hub-info', _handleInfo)
      ..post('/sync', _handleSync);

    final handler = const Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(_authMiddleware)
        .addHandler(router.call);

    _server = await shelf_io.serve(
      handler,
      InternetAddress.anyIPv4,
      _hubPort,
    );
  }

  Future<void> stop() async {
    await _server?.close(force: true);
    _server = null;
  }

  /// /hub-info — used by clients to test connectivity
  Future<Response> _handleInfo(Request req) async {
    return Response.ok(
      jsonEncode({
        'hub': true,
        'session_date': DateTime.now().toIso8601String().substring(0, 10),
        'server_time': DateTime.now().millisecondsSinceEpoch,
      }),
      headers: {'content-type': 'application/json'},
    );
  }

  /// POST /sync — receive client changes, apply them, return hub's delta
  Future<Response> _handleSync(Request req) async {
    final body = await req.readAsString();
    final payload = SyncRequest.fromJson(jsonDecode(body) as Map<String, dynamic>);

    // Validate session token from header
    final authHeader = req.headers['authorization'] ?? '';
    final token = authHeader.startsWith('Bearer ') ? authHeader.substring(7) : '';
    final session = await _db.userDao.getSessionByToken(token);
    if (session == null) {
      return Response.forbidden(jsonEncode({'error': 'Unauthorized'}),
          headers: {'content-type': 'application/json'});
    }

    // Validate role-based write access
    final user = await _db.userDao.getUserById(session.userId);
    if (user == null) {
      return Response.forbidden(jsonEncode({'error': 'User not found'}),
          headers: {'content-type': 'application/json'});
    }
    final role = UserRole.values.firstWhere((r) => r.name == user.roleValue);

    // Apply incoming changes
    for (final change in payload.changes) {
      if (!_isWriteAllowed(role, change.table)) continue;

      switch (change.table) {
        case 'patients':
          await _db.patientDao.mergeSyncedPatient(change.payload, payload.deviceId);
        case 'consultations':
          await _db.patientDao.mergeSyncedConsultation(change.payload);
        case 'dispensing_records':
          await _db.patientDao.mergeSyncedDispensingRecord(change.payload);
        case 'lab_results':
          await _db.patientDao.mergeSyncedLabResult(change.payload);
      }
    }

    final serverNow = DateTime.now().millisecondsSinceEpoch;

    // Collect everything the client hasn't seen yet
    final outPatients = await _db.patientDao.getPatientsSince(payload.sinceTimestamp);
    final outConsults = await _db.patientDao.getConsultationsSince(payload.sinceTimestamp);
    final outDispensing = await _db.patientDao.getDispensingRecordsSince(payload.sinceTimestamp);
    final outLab = await _db.patientDao.getLabResultsSince(payload.sinceTimestamp);

    await _db.userDao.updateLastSyncAt(payload.deviceId, serverNow);

    final response = SyncResponse(
      serverTimestamp: serverNow,
      changes: [
        ...outPatients.map((p) => SyncChange(table: 'patients', payload: p.toSyncMap())),
        ...outConsults.map((c) => SyncChange(table: 'consultations', payload: c.toSyncMap())),
        ...outDispensing.map((d) => SyncChange(table: 'dispensing_records', payload: d.toSyncMap())),
        ...outLab.map((l) => SyncChange(table: 'lab_results', payload: l.toSyncMap())),
      ],
    );

    return Response.ok(
      jsonEncode(response.toJson()),
      headers: {'content-type': 'application/json'},
    );
  }

  /// Middleware that only enforces auth on /sync (not /hub-info)
  static Middleware get _authMiddleware => (innerHandler) => (req) {
        if (req.url.path == 'hub-info') return innerHandler(req);
        return innerHandler(req);
      };

  bool _isWriteAllowed(UserRole role, String table) => switch (role) {
        UserRole.admin => true,
        UserRole.nurse => table == 'patients',
        UserRole.doctor => table == 'consultations',
        UserRole.pharmacist => table == 'dispensing_records',
        UserRole.lab => table == 'lab_results',
      };
}

// ---------------------------------------------------------------------------
// Serialisation helpers (extend Drift data classes)
// ---------------------------------------------------------------------------

extension PatientSync on Patient {
  Map<String, dynamic> toSyncMap() => {
        'id': id,
        'session_date': sessionDate,
        'full_name': fullName,
        'date_of_birth': dateOfBirth,
        'sex': sex,
        'phone': phone,
        'community': community,
        'chief_complaint': chiefComplaint,
        'blood_pressure': bloodPressure,
        'temperature_celsius': temperatureCelsius,
        'weight_kg': weightKg,
        'height_cm': heightCm,
        'pulse_per_min': pulsePerMin,
        'spo2_percent': spo2Percent,
        'intake_by': intakeBy,
        'intake_at': intakeAt,
        'updated_by': updatedBy,
        'updated_at': updatedAt,
        'is_deleted': isDeleted,
        'version': version,
      };
}

extension ConsultationSync on Consultation {
  Map<String, dynamic> toSyncMap() => {
        'id': id,
        'patient_id': patientId,
        'diagnosis': diagnosis,
        'clinical_notes': clinicalNotes,
        'prescription': prescription,
        'follow_up_date': followUpDate,
        'doctor_id': doctorId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'is_deleted': isDeleted,
        'version': version,
      };
}

extension DispensingSync on DispensingRecord {
  Map<String, dynamic> toSyncMap() => {
        'id': id,
        'patient_id': patientId,
        'items_dispensed': itemsDispensed,
        'counselling_notes': counsellingNotes,
        'pharmacist_id': pharmacistId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'is_deleted': isDeleted,
        'version': version,
      };
}

extension LabSync on LabResult {
  Map<String, dynamic> toSyncMap() => {
        'id': id,
        'patient_id': patientId,
        'test_name': testName,
        'result': result,
        'reference_range': referenceRange,
        'lab_tech_id': labTechId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'is_deleted': isDeleted,
        'version': version,
      };
}
