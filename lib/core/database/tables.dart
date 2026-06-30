import 'package:drift/drift.dart';

/// Roles available in the system.
enum UserRole { nurse, doctor, pharmacist, lab, admin }

// ---------------------------------------------------------------------------
// Users & sessions
// ---------------------------------------------------------------------------

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get roleValue => text().named('role')();
  TextColumn get pinHash => text()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class Devices extends Table {
  TextColumn get id => text()();
  TextColumn get friendlyName => text()();
  BoolColumn get isHub => boolean().withDefault(const Constant(false))();
  IntColumn get lastSeenAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Sessions extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get deviceId => text()();
  TextColumn get token => text()();
  IntColumn get createdAt => integer()();
  IntColumn get expiresAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// ---------------------------------------------------------------------------
// Patient records
// ---------------------------------------------------------------------------

/// Core patient row — owned by intake nurse.
/// Other role sections are in separate tables linked by patient_id.
class Patients extends Table {
  // Identity
  TextColumn get id => text()();
  TextColumn get sessionDate => text()(); // ISO date YYYY-MM-DD

  // Demographic (nurse)
  TextColumn get fullName => text()();
  TextColumn get dateOfBirth => text().nullable()();
  TextColumn get sex => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get community => text().nullable()();
  TextColumn get chiefComplaint => text().nullable()();

  // Vitals (nurse)
  TextColumn get bloodPressure => text().nullable()();
  RealColumn get temperatureCelsius => real().nullable()();
  RealColumn get weightKg => real().nullable()();
  RealColumn get heightCm => real().nullable()();
  IntColumn get pulsePerMin => integer().nullable()();
  RealColumn get spo2Percent => real().nullable()();

  // Audit
  TextColumn get intakeBy => text().nullable()();   // user id
  IntColumn get intakeAt => integer().nullable()();
  TextColumn get updatedBy => text().nullable()();
  IntColumn get updatedAt => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  IntColumn get version => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

class Consultations extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text().references(Patients, #id)();
  TextColumn get diagnosis => text().nullable()();
  TextColumn get clinicalNotes => text().nullable()();
  TextColumn get prescription => text().nullable()(); // JSON array
  TextColumn get followUpDate => text().nullable()();
  TextColumn get doctorId => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  IntColumn get version => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

class DispensingRecords extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text().references(Patients, #id)();
  TextColumn get itemsDispensed => text().nullable()(); // JSON array
  TextColumn get counsellingNotes => text().nullable()();
  TextColumn get pharmacistId => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  IntColumn get version => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

class LabResults extends Table {
  TextColumn get id => text()();
  TextColumn get patientId => text().references(Patients, #id)();
  TextColumn get testName => text().nullable()();
  TextColumn get result => text().nullable()();
  TextColumn get referenceRange => text().nullable()();
  TextColumn get labTechId => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  IntColumn get version => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

// ---------------------------------------------------------------------------
// Audit & sync
// ---------------------------------------------------------------------------

class AuditLog extends Table {
  TextColumn get id => text()();
  TextColumn get targetTable => text()(); // the table that was modified
  TextColumn get recordId => text()();
  TextColumn get fieldName => text()();
  TextColumn get oldValue => text().nullable()();
  TextColumn get newValue => text().nullable()();
  TextColumn get changedBy => text()(); // user id
  IntColumn get changedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tracks the last successful sync timestamp per peer device.
class SyncState extends Table {
  TextColumn get deviceId => text()();
  IntColumn get lastSyncAt => integer()();

  @override
  Set<Column> get primaryKey => {deviceId};
}
