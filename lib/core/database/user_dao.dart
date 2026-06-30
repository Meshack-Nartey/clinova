import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'app_database.dart';
import 'tables.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users, Sessions, Devices, SyncState])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  static final _uuid = Uuid();

  // ---------------------------------------------------------------------------
  // Users
  // ---------------------------------------------------------------------------

  Future<User?> getUserById(String id) =>
      (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();

  Future<User?> getUserByName(String name) =>
      (select(users)..where((u) => u.name.equals(name))).getSingleOrNull();

  Future<List<User>> getAllUsers() => select(users).get();

  Future<String> createUser({
    required String name,
    required UserRole role,
    required String pinHash,
  }) async {
    final id = _uuid.v4();
    await into(users).insert(UsersCompanion(
      id: Value(id),
      name: Value(name),
      roleValue: Value(role.name),
      pinHash: Value(pinHash),
      createdAt: Value(DateTime.now().millisecondsSinceEpoch),
    ));
    return id;
  }

  // ---------------------------------------------------------------------------
  // Sessions
  // ---------------------------------------------------------------------------

  Future<Session?> getSessionByToken(String token) =>
      (select(sessions)..where((s) => s.token.equals(token))).getSingleOrNull();

  Future<String> createSession({
    required String userId,
    required String deviceId,
    required String token,
    required int expiresAt,
  }) async {
    final id = _uuid.v4();
    await into(sessions).insert(SessionsCompanion(
      id: Value(id),
      userId: Value(userId),
      deviceId: Value(deviceId),
      token: Value(token),
      createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      expiresAt: Value(expiresAt),
    ));
    return id;
  }

  Future<void> deleteSession(String token) =>
      (delete(sessions)..where((s) => s.token.equals(token))).go();

  Future<void> purgeExpiredSessions() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (delete(sessions)..where((s) => s.expiresAt.isSmallerThanValue(now))).go();
  }

  // ---------------------------------------------------------------------------
  // Devices
  // ---------------------------------------------------------------------------

  Future<void> upsertDevice({
    required String id,
    required String friendlyName,
    required bool isHubDevice,
  }) async {
    await into(devices).insert(
      DevicesCompanion(
        id: Value(id),
        friendlyName: Value(friendlyName),
        isHub: Value(isHubDevice),
        lastSeenAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  // ---------------------------------------------------------------------------
  // Sync state
  // ---------------------------------------------------------------------------

  Future<int> getLastSyncAt(String deviceId) async {
    final row = await (select(syncState)..where((s) => s.deviceId.equals(deviceId)))
        .getSingleOrNull();
    return row?.lastSyncAt ?? 0;
  }

  Future<void> updateLastSyncAt(String deviceId, int timestamp) =>
      into(syncState).insert(
        SyncStateCompanion(
          deviceId: Value(deviceId),
          lastSyncAt: Value(timestamp),
        ),
        mode: InsertMode.insertOrReplace,
      );
}
