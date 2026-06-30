import 'package:drift/drift.dart';

import 'db_factory_io.dart'
    if (dart.library.html) 'db_factory_web.dart' as db_factory;
import 'patient_dao.dart';
import 'tables.dart';
import 'user_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    Devices,
    Sessions,
    Patients,
    Consultations,
    DispensingRecords,
    LabResults,
    AuditLog,
    SyncState,
  ],
  daos: [PatientDao, UserDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
      );
}

/// Opens the database, using the right adapter for the current platform.
Future<AppDatabase> openAppDatabase(String encryptionKey) =>
    db_factory.openAppDatabaseImpl(encryptionKey);
