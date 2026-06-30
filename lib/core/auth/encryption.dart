import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

const _keyStorageKey = 'clinova_db_key';
const _deviceIdKey = 'clinova_device_id';

const _secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
);

/// Returns the persistent device ID, creating one on first run.
Future<String> getOrCreateDeviceId() async {
  if (Platform.isMacOS) return macFileRead(_deviceIdKey, () => const Uuid().v4());
  var id = await _secureStorage.read(key: _deviceIdKey);
  if (id == null) {
    id = const Uuid().v4();
    await _secureStorage.write(key: _deviceIdKey, value: id);
  }
  return id;
}

/// Returns the persistent database encryption key, creating one on first run.
Future<String> getOrCreateDbKey() async {
  if (Platform.isMacOS) {
    return macFileRead(_keyStorageKey, () {
      return const Uuid().v4().replaceAll('-', '') + const Uuid().v4().replaceAll('-', '');
    });
  }
  var key = await _secureStorage.read(key: _keyStorageKey);
  if (key == null) {
    // 32-byte random key encoded as hex
    key = const Uuid().v4().replaceAll('-', '') + const Uuid().v4().replaceAll('-', '');
    await _secureStorage.write(key: _keyStorageKey, value: key);
  }
  return key;
}

/// File-based storage for macOS (avoids Keychain entitlement requirement in dev).
Future<String> macFileRead(String key, String Function() generate) async {
  final dir = await getApplicationSupportDirectory();
  final file = File('${dir.path}/.$key');
  if (file.existsSync()) return file.readAsStringSync().trim();
  final value = generate();
  file.writeAsStringSync(value);
  return value;
}

Future<void> macFileWrite(String key, String value) async {
  final dir = await getApplicationSupportDirectory();
  File('${dir.path}/.$key').writeAsStringSync(value);
}

Future<String?> macFileReadNullable(String key) async {
  final dir = await getApplicationSupportDirectory();
  final file = File('${dir.path}/.$key');
  return file.existsSync() ? file.readAsStringSync().trim() : null;
}

Future<void> macFileDelete(String key) async {
  final dir = await getApplicationSupportDirectory();
  final file = File('${dir.path}/.$key');
  if (file.existsSync()) file.deleteSync();
}

/// One-way hash a PIN for storage. Uses SHA-256 with a device-specific salt.
Future<String> hashPin(String pin) async {
  final deviceId = await getOrCreateDeviceId();
  final salted = '$deviceId:$pin';
  final bytes = utf8.encode(salted);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

/// Verify a PIN against its stored hash.
Future<bool> verifyPin(String pin, String storedHash) async {
  final hash = await hashPin(pin);
  return hash == storedHash;
}
