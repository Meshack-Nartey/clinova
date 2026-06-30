import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth/providers.dart';
import '../../core/database/tables.dart';

/// Shows [child] only when the current user has one of [allowedRoles].
/// Otherwise renders a read-only banner.
class RoleGuard extends ConsumerWidget {
  final List<UserRole> allowedRoles;
  final Widget child;
  final Widget? fallback;

  const RoleGuard({
    super.key,
    required this.allowedRoles,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider).valueOrNull;
    if (session != null && allowedRoles.contains(session.role)) {
      return child;
    }
    return fallback ??
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.lock_outline, size: 16, color: Colors.grey.shade500),
              const SizedBox(width: 8),
              Text(
                'Read-only for your role',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
            ],
          ),
        );
  }
}
