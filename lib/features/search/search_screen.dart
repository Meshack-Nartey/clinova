import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth/providers.dart';
import '../../core/database/tables.dart';
import '../../core/models/patient_providers.dart';
import '../../shared/routing/router.dart';
import '../../shared/widgets/sync_status_badge.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final resultsAsync = ref.watch(searchProvider(_query));
    final session = ref.watch(sessionProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(
        leading: _canGoBack(session?.role)
            ? BackButton(onPressed: () => context.go(routeDashboard))
            : null,
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search by name or ID…',
            border: InputBorder.none,
          ),
          onChanged: (v) => setState(() => _query = v.trim()),
        ),
        actions: const [SyncStatusBadge(), SizedBox(width: 16)],
      ),
      body: _query.isEmpty
          ? Center(
              child: Text('Type a name or patient ID',
                  style: TextStyle(color: Colors.grey.shade500)),
            )
          : resultsAsync.when(
              data: (patients) => patients.isEmpty
                  ? Center(
                      child: Text('No patients found for "$_query"',
                          style: TextStyle(color: Colors.grey.shade500)))
                  : ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: patients.length,
                      separatorBuilder: (ctx, i) => const Divider(height: 1),
                      itemBuilder: (ctx, i) {
                        final p = patients[i];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(p.fullName.isNotEmpty
                                ? p.fullName[0].toUpperCase()
                                : '?'),
                          ),
                          title: Text(p.fullName),
                          subtitle: Text(p.community ?? p.sessionDate),
                          onTap: () => _navigate(context, session?.role, p.id),
                        );
                      },
                    ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
    );
  }

  void _navigate(BuildContext context, UserRole? role, String patientId) =>
      switch (role) {
        UserRole.pharmacist => context.go('/pharmacy/$patientId'),
        UserRole.lab => context.go('/lab/$patientId'),
        UserRole.doctor => context.go('/consultation/$patientId'),
        _ => context.go('/intake/$patientId'),
      };

  bool _canGoBack(UserRole? role) =>
      role == UserRole.admin || role == UserRole.doctor;
}
