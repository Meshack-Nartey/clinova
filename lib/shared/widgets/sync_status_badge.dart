import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/sync/sync_providers.dart';

class SyncStatusBadge extends ConsumerWidget {
  const SyncStatusBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHub = ref.watch(isHubModeProvider);
    if (isHub) return _dot(Colors.blue, 'Hub on');

    final status = ref.watch(syncStatusProvider);
    return switch (status) {
      SyncStatus.live => _dot(Colors.green, 'Synced'),
      SyncStatus.syncing => _dot(Colors.orange, 'Syncing…'),
      SyncStatus.error => _dot(Colors.red, 'Offline'),
      SyncStatus.disabled => _dot(Colors.grey, 'No hub'),
    };
  }

  Widget _dot(Color color, String label) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      );
}
