import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/auth/auth_service.dart';
import 'core/auth/providers.dart';
import 'core/database/tables.dart';
import 'shared/routing/router.dart';
import 'shared/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: ClinovaApp()));
}

class ClinovaApp extends ConsumerWidget {
  const ClinovaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbAsync = ref.watch(databaseProvider);

    return dbAsync.when(
      data: (db) {
        // Seed the Admin account on first run only (no-op if already exists).
        // All other staff are registered through the Manage Staff screen.
        AuthService(db).seedUsers([
          (name: 'Admin', role: UserRole.admin, pin: '0000'),
        ]);

        final router = ref.watch(routerProvider);
        return MaterialApp.router(
          title: 'Clinova',
          theme: appTheme,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        );
      },
      loading: () => const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (e, _) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              'Failed to open database:\n$e',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
