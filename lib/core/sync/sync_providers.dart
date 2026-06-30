import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/providers.dart';
import 'hub_server.dart';
import 'sync_client.dart';

enum SyncStatus { live, syncing, error, disabled }

// ---------------------------------------------------------------------------
// Hub mode
// ---------------------------------------------------------------------------

final isHubModeProvider = StateProvider<bool>((ref) => false);

final hubServerProvider = StateNotifierProvider<HubServerNotifier, HubServer?>((ref) {
  return HubServerNotifier(ref);
});

class HubServerNotifier extends StateNotifier<HubServer?> {
  final Ref _ref;
  HubServerNotifier(this._ref) : super(null);

  Future<void> start() async {
    final db = _ref.read(databaseProvider).requireValue;
    final server = HubServer(db);
    await server.start();
    state = server;
    _ref.read(isHubModeProvider.notifier).state = true;
  }

  Future<void> stop() async {
    await state?.stop();
    state = null;
    _ref.read(isHubModeProvider.notifier).state = false;
  }
}

// ---------------------------------------------------------------------------
// Sync client
// ---------------------------------------------------------------------------

final syncStatusProvider = StateProvider<SyncStatus>((ref) => SyncStatus.disabled);

final syncClientProvider = StateNotifierProvider<SyncClientNotifier, SyncClient?>((ref) {
  return SyncClientNotifier(ref);
});

class SyncClientNotifier extends StateNotifier<SyncClient?> {
  final Ref _ref;
  SyncClientNotifier(this._ref) : super(null);

  Future<void> connect(String hubBaseUrl) async {
    await state?.stop();
    final db = _ref.read(databaseProvider).requireValue;
    final session = _ref.read(sessionProvider).requireValue;

    final client = SyncClient(
      db: db,
      hubBaseUrl: hubBaseUrl,
      sessionToken: session?.token ?? '',
      onStatusChange: (s) =>
          _ref.read(syncStatusProvider.notifier).state = s,
    );
    await client.start();
    state = client;
  }

  Future<void> disconnect() async {
    await state?.stop();
    state = null;
    _ref.read(syncStatusProvider.notifier).state = SyncStatus.disabled;
  }
}
