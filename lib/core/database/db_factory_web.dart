import 'package:drift/wasm.dart';
import 'package:sqlite3/wasm.dart';

import 'app_database.dart';

// Web uses WASM SQLite + IndexedDB; production deployments run on Android/macOS.
Future<AppDatabase> openAppDatabaseImpl(String encryptionKey) async {
  final wasm =
      await WasmSqlite3.loadFromUrl(Uri.parse('/sqlite3.wasm'));
  final fs = await IndexedDbFileSystem.open(dbName: 'clinova');
  wasm.registerVirtualFileSystem(fs, makeDefault: true);
  return AppDatabase(
    WasmDatabase(sqlite3: wasm, path: '/clinova.db', fileSystem: fs),
  );
}
