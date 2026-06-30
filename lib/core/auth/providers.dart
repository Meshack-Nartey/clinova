import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import 'auth_service.dart';
import 'encryption.dart';

// ---------------------------------------------------------------------------
// Database provider — singleton opened once on app start
// ---------------------------------------------------------------------------

final databaseProvider = FutureProvider<AppDatabase>((ref) async {
  final key = await getOrCreateDbKey();
  return openAppDatabase(key);
});

// ---------------------------------------------------------------------------
// Auth service
// ---------------------------------------------------------------------------

final authServiceProvider = Provider<AuthService>((ref) {
  final db = ref.watch(databaseProvider).requireValue;
  return AuthService(db);
});

// ---------------------------------------------------------------------------
// Current session — null when logged out
// ---------------------------------------------------------------------------

final sessionProvider = StateNotifierProvider<SessionNotifier, AsyncValue<AuthSession?>>((ref) {
  return SessionNotifier(ref.watch(authServiceProvider));
});

class SessionNotifier extends StateNotifier<AsyncValue<AuthSession?>> {
  final AuthService _auth;

  SessionNotifier(this._auth) : super(const AsyncLoading()) {
    _restore();
  }

  Future<void> _restore() async {
    try {
      final session = await _auth.restoreSession();
      state = AsyncData(session);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> login(String name, String pin) async {
    state = const AsyncLoading();
    try {
      final session = await _auth.login(name, pin);
      state = AsyncData(session);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> logout() async {
    await _auth.logout();
    state = const AsyncData(null);
  }
}
