import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../database/app_database.dart';
import '../database/tables.dart';
import 'encryption.dart';

const _sessionTokenKey = 'clinova_session_token';
const _secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
);

class AuthSession {
  final String userId;
  final String userName;
  final UserRole role;
  final String token;

  const AuthSession({
    required this.userId,
    required this.userName,
    required this.role,
    required this.token,
  });
}

class AuthService {
  final AppDatabase _db;

  AuthService(this._db);

  /// Log in with a name and PIN. Returns an [AuthSession] or throws.
  Future<AuthSession> login(String name, String pin) async {
    final user = await _db.userDao.getUserByName(name);
    if (user == null) throw Exception('User not found');

    final valid = await verifyPin(pin, user.pinHash);
    if (!valid) throw Exception('Incorrect PIN');

    final token = _generateToken();
    final deviceId = await getOrCreateDeviceId();
    final expiresAt = DateTime.now().add(const Duration(hours: 12)).millisecondsSinceEpoch;

    await _db.userDao.createSession(
      userId: user.id,
      deviceId: deviceId,
      token: token,
      expiresAt: expiresAt,
    );

    if (Platform.isMacOS) {
      await macFileWrite(_sessionTokenKey, token);
    } else {
      await _secureStorage.write(key: _sessionTokenKey, value: token);
    }

    return AuthSession(
      userId: user.id,
      userName: user.name,
      role: UserRole.values.firstWhere((r) => r.name == user.roleValue),
      token: token,
    );
  }

  /// Restore a persisted session from secure storage, if still valid.
  Future<AuthSession?> restoreSession() async {
    final token = Platform.isMacOS
        ? await macFileReadNullable(_sessionTokenKey)
        : await _secureStorage.read(key: _sessionTokenKey);
    if (token == null) return null;

    final session = await _db.userDao.getSessionByToken(token);
    if (session == null) return null;

    if (session.expiresAt < DateTime.now().millisecondsSinceEpoch) {
      await logout();
      return null;
    }

    final user = await _db.userDao.getUserById(session.userId);
    if (user == null) return null;

    return AuthSession(
      userId: user.id,
      userName: user.name,
      role: UserRole.values.firstWhere((r) => r.name == user.roleValue),
      token: token,
    );
  }

  Future<void> logout() async {
    final token = Platform.isMacOS
        ? await macFileReadNullable(_sessionTokenKey)
        : await _secureStorage.read(key: _sessionTokenKey);
    if (token != null) {
      await _db.userDao.deleteSession(token);
    }
    if (Platform.isMacOS) {
      await macFileDelete(_sessionTokenKey);
    } else {
      await _secureStorage.delete(key: _sessionTokenKey);
    }
  }

  /// Seed the database with initial users. Used once during setup.
  /// In production replace with an admin UI.
  Future<void> seedUsers(List<({String name, UserRole role, String pin})> users) async {
    for (final u in users) {
      final existing = await _db.userDao.getUserByName(u.name);
      if (existing != null) continue;

      final pinHash = await hashPin(u.pin);
      await _db.userDao.createUser(
        name: u.name,
        role: u.role,
        pinHash: pinHash,
      );
    }
  }

  String _generateToken() {
    final rng = Random.secure();
    final bytes = List<int>.generate(32, (_) => rng.nextInt(256));
    return base64Url.encode(bytes);
  }
}
