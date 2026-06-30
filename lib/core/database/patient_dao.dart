import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'app_database.dart';
import 'tables.dart';

part 'patient_dao.g.dart';

@DriftAccessor(tables: [
  Patients,
  Consultations,
  DispensingRecords,
  LabResults,
  AuditLog,
])
class PatientDao extends DatabaseAccessor<AppDatabase> with _$PatientDaoMixin {
  PatientDao(super.db);

  static final _uuid = Uuid();

  // ---------------------------------------------------------------------------
  // Patients
  // ---------------------------------------------------------------------------

  Stream<List<Patient>> watchActivePatients(String sessionDate) => (select(patients)
        ..where((p) => p.sessionDate.equals(sessionDate) & p.isDeleted.equals(false))
        ..orderBy([(p) => OrderingTerm(expression: p.intakeAt, mode: OrderingMode.desc)]))
      .watch();

  Future<Patient?> getPatient(String id) =>
      (select(patients)..where((p) => p.id.equals(id))).getSingleOrNull();

  Future<List<Patient>> searchPatients(String query) =>
      (select(patients)
            ..where((p) =>
                p.isDeleted.equals(false) &
                (p.fullName.like('%$query%') | p.id.like('%$query%'))))
          .get();

  Future<String> createPatient(PatientsCompanion data, String createdByUserId) async {
    final id = data.id.present ? data.id.value : _uuid.v4();
    final now = DateTime.now().millisecondsSinceEpoch;

    final row = data.copyWith(
      id: Value(id),
      intakeBy: Value(createdByUserId),
      intakeAt: Value(now),
      updatedBy: Value(createdByUserId),
      updatedAt: Value(now),
      version: const Value(1),
    );

    await into(patients).insert(row, mode: InsertMode.insertOrReplace);
    return id;
  }

  Future<void> updatePatient(
    String id,
    PatientsCompanion data,
    String updatedByUserId,
  ) async {
    final existing = await getPatient(id);
    if (existing == null) return;

    final now = DateTime.now().millisecondsSinceEpoch;
    final updated = data.copyWith(
      updatedBy: Value(updatedByUserId),
      updatedAt: Value(now),
      version: Value(existing.version + 1),
    );

    await _logAudit(existing.toAuditMap(), updated.toAuditMap(), id, 'patients', updatedByUserId, now);
    await (update(patients)..where((p) => p.id.equals(id))).write(updated);
  }

  Future<void> softDeletePatient(String id, String userId) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (update(patients)..where((p) => p.id.equals(id))).write(
      PatientsCompanion(
        isDeleted: const Value(true),
        updatedBy: Value(userId),
        updatedAt: Value(now),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Consultations
  // ---------------------------------------------------------------------------

  Future<Consultation?> getConsultation(String patientId) =>
      (select(consultations)
            ..where((c) => c.patientId.equals(patientId) & c.isDeleted.equals(false)))
          .getSingleOrNull();

  Future<String> upsertConsultation(ConsultationsCompanion data, String doctorId) async {
    final id = data.id.present ? data.id.value : _uuid.v4();
    final now = DateTime.now().millisecondsSinceEpoch;

    final row = data.copyWith(
      id: Value(id),
      doctorId: Value(doctorId),
      createdAt: data.createdAt.present ? data.createdAt : Value(now),
      updatedAt: Value(now),
    );

    await into(consultations).insert(row, mode: InsertMode.insertOrReplace);
    return id;
  }

  // ---------------------------------------------------------------------------
  // Dispensing
  // ---------------------------------------------------------------------------

  Future<DispensingRecord?> getDispensingRecord(String patientId) =>
      (select(dispensingRecords)
            ..where((d) => d.patientId.equals(patientId) & d.isDeleted.equals(false)))
          .getSingleOrNull();

  Future<String> upsertDispensingRecord(
      DispensingRecordsCompanion data, String pharmacistId) async {
    final id = data.id.present ? data.id.value : _uuid.v4();
    final now = DateTime.now().millisecondsSinceEpoch;

    final row = data.copyWith(
      id: Value(id),
      pharmacistId: Value(pharmacistId),
      createdAt: data.createdAt.present ? data.createdAt : Value(now),
      updatedAt: Value(now),
    );

    await into(dispensingRecords).insert(row, mode: InsertMode.insertOrReplace);
    return id;
  }

  // ---------------------------------------------------------------------------
  // Lab results
  // ---------------------------------------------------------------------------

  Future<List<LabResult>> getLabResults(String patientId) =>
      (select(labResults)
            ..where((l) => l.patientId.equals(patientId) & l.isDeleted.equals(false)))
          .get();

  Future<String> upsertLabResult(LabResultsCompanion data, String labTechId) async {
    final id = data.id.present ? data.id.value : _uuid.v4();
    final now = DateTime.now().millisecondsSinceEpoch;

    final row = data.copyWith(
      id: Value(id),
      labTechId: Value(labTechId),
      createdAt: data.createdAt.present ? data.createdAt : Value(now),
      updatedAt: Value(now),
    );

    await into(labResults).insert(row, mode: InsertMode.insertOrReplace);
    return id;
  }

  // ---------------------------------------------------------------------------
  // Sync helpers — used by the sync engine
  // ---------------------------------------------------------------------------

  Future<List<Patient>> getPatientsSince(int timestamp) =>
      (select(patients)..where((p) => p.updatedAt.isBiggerThanValue(timestamp))).get();

  Future<List<Consultation>> getConsultationsSince(int timestamp) =>
      (select(consultations)..where((c) => c.updatedAt.isBiggerThanValue(timestamp))).get();

  Future<List<DispensingRecord>> getDispensingRecordsSince(int timestamp) =>
      (select(dispensingRecords)..where((d) => d.updatedAt.isBiggerThanValue(timestamp))).get();

  Future<List<LabResult>> getLabResultsSince(int timestamp) =>
      (select(labResults)..where((l) => l.updatedAt.isBiggerThanValue(timestamp))).get();

  /// Merge an incoming patient from sync. Last-write-wins by updatedAt;
  /// conflicting values are written to audit_log.
  Future<void> mergeSyncedPatient(Map<String, dynamic> incoming, String sourceDeviceId) async {
    final incomingUpdatedAt = incoming['updated_at'] as int;
    final id = incoming['id'] as String;

    final existing = await getPatient(id);
    if (existing != null && existing.updatedAt >= incomingUpdatedAt) {
      // Log the conflict — don't overwrite
      await into(auditLog).insert(AuditLogCompanion(
        id: Value(_uuid.v4()),
        targetTable: const Value('patients'),
        recordId: Value(id),
        fieldName: const Value('__conflict__'),
        oldValue: Value(existing.updatedAt.toString()),
        newValue: Value(incomingUpdatedAt.toString()),
        changedBy: Value(sourceDeviceId),
        changedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));
      return;
    }

    await into(patients).insert(
      _patientFromMap(incoming),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> mergeSyncedConsultation(Map<String, dynamic> incoming) async {
    await into(consultations).insert(
      _consultationFromMap(incoming),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> mergeSyncedDispensingRecord(Map<String, dynamic> incoming) async {
    await into(dispensingRecords).insert(
      _dispensingFromMap(incoming),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> mergeSyncedLabResult(Map<String, dynamic> incoming) async {
    await into(labResults).insert(
      _labResultFromMap(incoming),
      mode: InsertMode.insertOrReplace,
    );
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  PatientsCompanion _patientFromMap(Map<String, dynamic> m) => PatientsCompanion(
        id: Value(m['id'] as String),
        sessionDate: Value(m['session_date'] as String),
        fullName: Value(m['full_name'] as String),
        dateOfBirth: Value(m['date_of_birth'] as String?),
        sex: Value(m['sex'] as String?),
        phone: Value(m['phone'] as String?),
        community: Value(m['community'] as String?),
        chiefComplaint: Value(m['chief_complaint'] as String?),
        bloodPressure: Value(m['blood_pressure'] as String?),
        temperatureCelsius: Value((m['temperature_celsius'] as num?)?.toDouble()),
        weightKg: Value((m['weight_kg'] as num?)?.toDouble()),
        heightCm: Value((m['height_cm'] as num?)?.toDouble()),
        pulsePerMin: Value(m['pulse_per_min'] as int?),
        spo2Percent: Value((m['spo2_percent'] as num?)?.toDouble()),
        intakeBy: Value(m['intake_by'] as String?),
        intakeAt: Value(m['intake_at'] as int?),
        updatedBy: Value(m['updated_by'] as String?),
        updatedAt: Value(m['updated_at'] as int),
        isDeleted: Value((m['is_deleted'] as bool?) ?? false),
        version: Value((m['version'] as int?) ?? 1),
      );

  ConsultationsCompanion _consultationFromMap(Map<String, dynamic> m) =>
      ConsultationsCompanion(
        id: Value(m['id'] as String),
        patientId: Value(m['patient_id'] as String),
        diagnosis: Value(m['diagnosis'] as String?),
        clinicalNotes: Value(m['clinical_notes'] as String?),
        prescription: Value(m['prescription'] as String?),
        followUpDate: Value(m['follow_up_date'] as String?),
        doctorId: Value(m['doctor_id'] as String?),
        createdAt: Value(m['created_at'] as int),
        updatedAt: Value(m['updated_at'] as int),
        isDeleted: Value((m['is_deleted'] as bool?) ?? false),
        version: Value((m['version'] as int?) ?? 1),
      );

  DispensingRecordsCompanion _dispensingFromMap(Map<String, dynamic> m) =>
      DispensingRecordsCompanion(
        id: Value(m['id'] as String),
        patientId: Value(m['patient_id'] as String),
        itemsDispensed: Value(m['items_dispensed'] as String?),
        counsellingNotes: Value(m['counselling_notes'] as String?),
        pharmacistId: Value(m['pharmacist_id'] as String?),
        createdAt: Value(m['created_at'] as int),
        updatedAt: Value(m['updated_at'] as int),
        isDeleted: Value((m['is_deleted'] as bool?) ?? false),
        version: Value((m['version'] as int?) ?? 1),
      );

  LabResultsCompanion _labResultFromMap(Map<String, dynamic> m) => LabResultsCompanion(
        id: Value(m['id'] as String),
        patientId: Value(m['patient_id'] as String),
        testName: Value(m['test_name'] as String?),
        result: Value(m['result'] as String?),
        referenceRange: Value(m['reference_range'] as String?),
        labTechId: Value(m['lab_tech_id'] as String?),
        createdAt: Value(m['created_at'] as int),
        updatedAt: Value(m['updated_at'] as int),
        isDeleted: Value((m['is_deleted'] as bool?) ?? false),
        version: Value((m['version'] as int?) ?? 1),
      );

  Future<void> _logAudit(
    Map<String, dynamic> oldMap,
    Map<String, dynamic> newMap,
    String recordId,
    String targetTableName,
    String userId,
    int changedAt,
  ) async {
    for (final key in newMap.keys) {
      final oldVal = oldMap[key]?.toString();
      final newVal = newMap[key]?.toString();
      if (oldVal != newVal) {
        await into(auditLog).insert(AuditLogCompanion(
          id: Value(_uuid.v4()),
          targetTable: Value(targetTableName),
          recordId: Value(recordId),
          fieldName: Value(key),
          oldValue: Value(oldVal),
          newValue: Value(newVal),
          changedBy: Value(userId),
          changedAt: Value(changedAt),
        ));
      }
    }
  }
}

extension on Patient {
  Map<String, dynamic> toAuditMap() => {
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
      };
}

extension on PatientsCompanion {
  Map<String, dynamic> toAuditMap() => {
        'full_name': fullName.present ? fullName.value : null,
        'date_of_birth': dateOfBirth.present ? dateOfBirth.value : null,
        'sex': sex.present ? sex.value : null,
        'phone': phone.present ? phone.value : null,
        'community': community.present ? community.value : null,
        'chief_complaint': chiefComplaint.present ? chiefComplaint.value : null,
        'blood_pressure': bloodPressure.present ? bloodPressure.value : null,
        'temperature_celsius': temperatureCelsius.present ? temperatureCelsius.value : null,
        'weight_kg': weightKg.present ? weightKg.value : null,
        'height_cm': heightCm.present ? heightCm.value : null,
        'pulse_per_min': pulsePerMin.present ? pulsePerMin.value : null,
        'spo2_percent': spo2Percent.present ? spo2Percent.value : null,
      };
}
