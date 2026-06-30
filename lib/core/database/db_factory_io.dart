import 'dart:io';

import 'package:drift/native.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' show getDatabasesPath;

import 'app_database.dart';

Future<AppDatabase> openAppDatabaseImpl(String encryptionKey) async {
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    final dbFolder = await getDatabasesPath();
    final file = File(p.join(dbFolder, 'clinova.db'));
    return AppDatabase(SqfliteQueryExecutor(path: file.path));
  }

  final dir = await getApplicationSupportDirectory();
  final file = File(p.join(dir.path, 'clinova.db'));
  return AppDatabase(NativeDatabase.createInBackground(
    file,
    setup: (db) {
      db.execute("PRAGMA key = '$encryptionKey'");
      db.execute('PRAGMA journal_mode = WAL');
    },
  ));
}
