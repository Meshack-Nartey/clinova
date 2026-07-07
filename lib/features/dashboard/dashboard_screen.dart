import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/auth/providers.dart';
import '../../core/database/app_database.dart';
import '../../core/settings/settings_providers.dart';
import '../../core/database/tables.dart';
import '../../core/models/patient_providers.dart';
import '../../core/sync/sync_providers.dart';
import '../../shared/routing/router.dart';
import '../../shared/widgets/clinova_logo.dart';
import '../../shared/widgets/sync_status_badge.dart';
import 'hub_setup_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.watch(activePatientsProvider);
    final session = ref.watch(sessionProvider).valueOrNull;
    final isHub = ref.watch(isHubModeProvider);
    final canAdd = _canCreatePatient(session?.role);
    final clinicName = ref.watch(clinicNameProvider).valueOrNull;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        titleSpacing: 16,
        title: Row(
          children: [
            const ClinovaLogo(
              size: 34,
              foreground: Colors.white,
              background: Color(0xFF111111),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clinicName ?? 'Clinova',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.3),
                ),
                Text(
                  DateFormat('EEE, d MMM').format(DateTime.now()),
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Color(0xFFAAAAAA)),
                ),
              ],
            ),
          ],
        ),
        actions: [
          const SyncStatusBadge(),
          const SizedBox(width: 2),
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
          if (canAdd)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: FilledButton.icon(
                onPressed: () => context.go(routeIntake),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('New patient'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF111111),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                  minimumSize: const Size(0, 36),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          if (session?.role == UserRole.admin)
            IconButton(
              icon: const Icon(Icons.manage_accounts_rounded),
              tooltip: 'Manage staff',
              onPressed: () => context.go(routeStaff),
            ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Sign out',
            onPressed: () => ref.read(sessionProvider.notifier).logout(),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: patientsAsync.when(
        data: (patients) {
          if (patients.isEmpty) return _EmptyState(canAdd: canAdd);
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            itemCount: patients.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
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
  final bool canAdd;
  const _EmptyState({required this.canAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: const Icon(Icons.people_alt_outlined, size: 40, color: Color(0xFFBBBBBB)),
            ),
            const SizedBox(height: 20),
            const Text(
              'No patients today',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF111111)),
            ),
            const SizedBox(height: 6),
            Text(
              canAdd
                  ? 'Tap "New patient" above to register the first patient for today\'s session.'
                  : 'Patients registered by a nurse will appear here.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Color(0xFF888888), height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientCard extends ConsumerWidget {
  final Patient patient;
  const _PatientCard({required this.patient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = patient;
    final consultAsync = ref.watch(consultationProvider(p.id));
    final dispensingAsync = ref.watch(dispensingProvider(p.id));
    final session = ref.read(sessionProvider).valueOrNull;

    final hasConsult = consultAsync.valueOrNull != null;
    final hasDispensing = dispensingAsync.valueOrNull != null;

    final name = p.fullName;
    final initials = name.isNotEmpty
        ? name.trim().split(' ').take(2).map((w) => w[0]).join().toUpperCase()
        : '?';

    final complaint = p.chiefComplaint;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _showPatientActions(context, ref, p, session),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFEEEEEE)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xFF111111)),
                    ),
                    if (complaint != null && complaint.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        complaint,
                        style: const TextStyle(fontSize: 13, color: Color(0xFF888888)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _StatusPill(hasConsult: hasConsult, hasDispensing: hasDispensing),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFFCCCCCC)),
            ],
          ),
        ),
      ),
    );
  }

  void _showPatientActions(BuildContext context, WidgetRef ref, Patient p, dynamic session) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(p.fullName,
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: Color(0xFF111111))),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person_outline_rounded),
              title: const Text('Edit intake record'),
              onTap: () { Navigator.pop(context); context.go('/intake/${p.id}'); },
            ),
            if (session?.role == UserRole.doctor || session?.role == UserRole.admin)
              ListTile(
                leading: const Icon(Icons.medical_services_outlined),
                title: const Text('Consultation'),
                onTap: () { Navigator.pop(context); context.go('/consultation/${p.id}'); },
              ),
            if (session?.role == UserRole.pharmacist || session?.role == UserRole.admin)
              ListTile(
                leading: const Icon(Icons.medication_outlined),
                title: const Text('Pharmacy / dispensing'),
                onTap: () { Navigator.pop(context); context.go('/pharmacy/${p.id}'); },
              ),
            if (session?.role == UserRole.lab || session?.role == UserRole.admin)
              ListTile(
                leading: const Icon(Icons.science_outlined),
                title: const Text('Lab results'),
                onTap: () { Navigator.pop(context); context.go('/lab/${p.id}'); },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final bool hasConsult;
  final bool hasDispensing;
  const _StatusPill({required this.hasConsult, required this.hasDispensing});

  @override
  Widget build(BuildContext context) {
    final (bg, fg, label) = hasDispensing
        ? (const Color(0xFF111111), Colors.white, 'Done')
        : hasConsult
            ? (const Color(0xFFEEEEEE), const Color(0xFF444444), 'Seen')
            : (const Color(0xFFF4F4F4), const Color(0xFF888888), 'Waiting');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: TextStyle(fontSize: 12, color: fg, fontWeight: FontWeight.w700)),
    );
  }
}
