import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/auth/providers.dart';
import '../../core/database/tables.dart';
import '../../core/models/patient_providers.dart';
import '../../core/sync/sync_providers.dart';
import '../../shared/routing/router.dart';
import '../../shared/widgets/sync_status_badge.dart';
import 'hub_setup_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.watch(activePatientsProvider);
    final session = ref.watch(sessionProvider).valueOrNull;
    final isHub = ref.watch(isHubModeProvider);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Patients today',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              DateFormat('EEEE, d MMM yyyy').format(DateTime.now()),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: colors.onSurfaceVariant),
            ),
          ],
        ),
        actions: [
          const SyncStatusBadge(),
          const SizedBox(width: 4),
          IconButton(
            icon: const Icon(Icons.search_rounded),
            tooltip: 'Search patients',
            onPressed: () => context.go(routeSearch),
          ),
          IconButton(
            icon: Icon(isHub ? Icons.hub_rounded : Icons.hub_outlined),
            tooltip: isHub ? 'Hub running' : 'Network setup',
            onPressed: () => showDialog(
              context: context,
              builder: (_) => Dialog(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: HubSetupSheet(
                    canStartHub: session?.role == UserRole.admin ||
                        session?.role == UserRole.doctor,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Sign out',
            onPressed: () => ref.read(sessionProvider.notifier).logout(),
          ),
          const SizedBox(width: 4),
        ],
      ),
      floatingActionButton: _canCreatePatient(session?.role)
          ? FloatingActionButton.extended(
              onPressed: () => context.go(routeIntake),
              icon: const Icon(Icons.person_add_alt_1_rounded),
              label: const Text('New patient'),
            )
          : null,
      body: patientsAsync.when(
        data: (patients) {
          if (patients.isEmpty) return const _EmptyState();
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
            itemCount: patients.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (_, i) => _PatientCard(patient: patients[i]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  bool _canCreatePatient(UserRole? role) =>
      role == UserRole.nurse || role == UserRole.admin;
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colors.primaryContainer.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.people_alt_outlined,
                size: 52, color: colors.primary.withValues(alpha: 0.7)),
          ),
          const SizedBox(height: 16),
          Text('No patients yet today',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: colors.onSurfaceVariant)),
          const SizedBox(height: 6),
          Text('Tap "+ New patient" to add the first one',
              style: TextStyle(fontSize: 13, color: colors.outline)),
        ],
      ),
    );
  }
}

class _PatientCard extends ConsumerWidget {
  final dynamic patient;
  const _PatientCard({required this.patient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = patient;
    final consultAsync = ref.watch(consultationProvider(p.id));
    final dispensingAsync = ref.watch(dispensingProvider(p.id));
    final colors = Theme.of(context).colorScheme;

    final hasConsult = consultAsync.valueOrNull != null;
    final hasDispensing = dispensingAsync.valueOrNull != null;

    final initials = (p.fullName as String).isNotEmpty
        ? (p.fullName as String).trim().split(' ').take(2).map((w) => w[0]).join()
        : '?';

    return Card(
      color: colors.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showPatientActions(context, ref, p),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: colors.primaryContainer,
                child: Text(
                  initials.toUpperCase(),
                  style: TextStyle(
                    color: colors.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.fullName as String,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(
                      p.chiefComplaint as String? ?? 'No complaint recorded',
                      style: TextStyle(
                          color: colors.onSurfaceVariant, fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _StatusChip(hasConsult: hasConsult, hasDispensing: hasDispensing),
            ],
          ),
        ),
      ),
    );
  }

  void _showPatientActions(BuildContext context, WidgetRef ref, dynamic p) {
    final session = ref.read(sessionProvider).valueOrNull;
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(p.fullName as String,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
            const Divider(height: 16),
            ListTile(
              leading: const Icon(Icons.person_outline_rounded),
              title: const Text('Edit intake record'),
              onTap: () {
                Navigator.pop(context);
                context.go('/intake/${p.id}');
              },
            ),
            if (session?.role == UserRole.doctor || session?.role == UserRole.admin)
              ListTile(
                leading: const Icon(Icons.medical_services_outlined),
                title: const Text('Consultation'),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/consultation/${p.id}');
                },
              ),
            if (session?.role == UserRole.pharmacist ||
                session?.role == UserRole.admin)
              ListTile(
                leading: const Icon(Icons.medication_outlined),
                title: const Text('Pharmacy / dispensing'),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/pharmacy/${p.id}');
                },
              ),
            if (session?.role == UserRole.lab || session?.role == UserRole.admin)
              ListTile(
                leading: const Icon(Icons.science_outlined),
                title: const Text('Lab results'),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/lab/${p.id}');
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final bool hasConsult;
  final bool hasDispensing;

  const _StatusChip({required this.hasConsult, required this.hasDispensing});

  @override
  Widget build(BuildContext context) {
    final (color, label, icon) = hasDispensing
        ? (Colors.green, 'Done', Icons.check_circle_outline_rounded)
        : hasConsult
            ? (Colors.blue, 'Seen', Icons.visibility_outlined)
            : (Colors.orange, 'Waiting', Icons.schedule_rounded);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
