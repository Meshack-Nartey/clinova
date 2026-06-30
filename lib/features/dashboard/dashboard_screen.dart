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

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Patients today'),
            Text(
              DateFormat('EEEE, d MMM yyyy').format(DateTime.now()),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        actions: [
          const SyncStatusBadge(),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search patients',
            onPressed: () => context.go(routeSearch),
          ),
          IconButton(
            icon: Icon(isHub ? Icons.hub : Icons.hub_outlined),
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
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
            onPressed: () => ref.read(sessionProvider.notifier).logout(),
          ),
          const SizedBox(width: 4),
        ],
      ),
      floatingActionButton: _canCreatePatient(session?.role)
          ? FloatingActionButton.extended(
              onPressed: () => context.go(routeIntake),
              icon: const Icon(Icons.person_add_outlined),
              label: const Text('New patient'),
            )
          : null,
      body: patientsAsync.when(
        data: (patients) {
          if (patients.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 12),
                  Text('No patients yet today',
                      style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: patients.length,
            separatorBuilder: (ctx, i) => const SizedBox(height: 4),
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

class _PatientCard extends ConsumerWidget {
  final dynamic patient; // Patient
  const _PatientCard({required this.patient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = patient;
    final consultAsync = ref.watch(consultationProvider(p.id));
    final dispensingAsync = ref.watch(dispensingProvider(p.id));

    final hasConsult = consultAsync.valueOrNull != null;
    final hasDispensing = dispensingAsync.valueOrNull != null;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showPatientActions(context, ref, p),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  (p.fullName as String).isNotEmpty
                      ? (p.fullName as String)[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.fullName as String,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    Text(
                      p.chiefComplaint as String? ?? 'No complaint recorded',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
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
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person_outline),
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
            if (session?.role == UserRole.pharmacist || session?.role == UserRole.admin)
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
    final color = hasDispensing
        ? Colors.green
        : hasConsult
            ? Colors.blue
            : Colors.orange;
    final label = hasDispensing ? 'Done' : hasConsult ? 'Seen' : 'Waiting';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
    );
  }
}
