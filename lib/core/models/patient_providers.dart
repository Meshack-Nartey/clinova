import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../auth/providers.dart';
import '../database/app_database.dart';

final _todaySession = DateFormat('yyyy-MM-dd').format(DateTime.now());

final activePatientsProvider = StreamProvider<List<Patient>>((ref) {
  final db = ref.watch(databaseProvider).requireValue;
  return db.patientDao.watchActivePatients(_todaySession);
});

final patientProvider = FutureProvider.family<Patient?, String>((ref, id) async {
  final db = ref.watch(databaseProvider).requireValue;
  return db.patientDao.getPatient(id);
});

final consultationProvider = FutureProvider.family<Consultation?, String>((ref, patientId) async {
  final db = ref.watch(databaseProvider).requireValue;
  return db.patientDao.getConsultation(patientId);
});

final dispensingProvider =
    FutureProvider.family<DispensingRecord?, String>((ref, patientId) async {
  final db = ref.watch(databaseProvider).requireValue;
  return db.patientDao.getDispensingRecord(patientId);
});

final labResultsProvider =
    FutureProvider.family<List<LabResult>, String>((ref, patientId) async {
  final db = ref.watch(databaseProvider).requireValue;
  return db.patientDao.getLabResults(patientId);
});

final searchProvider = FutureProvider.family<List<Patient>, String>((ref, query) async {
  if (query.isEmpty) return [];
  final db = ref.watch(databaseProvider).requireValue;
  return db.patientDao.searchPatients(query);
});
