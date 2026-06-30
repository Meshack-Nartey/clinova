import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth/providers.dart';
import '../../core/database/app_database.dart';
import '../../core/database/tables.dart';
import '../../core/models/patient_providers.dart';
import '../../shared/routing/router.dart';
import '../../shared/widgets/role_guard.dart';
import '../../shared/widgets/sync_status_badge.dart';

class ConsultationScreen extends ConsumerStatefulWidget {
  final String patientId;
  const ConsultationScreen({super.key, required this.patientId});

  @override
  ConsumerState<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends ConsumerState<ConsultationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  bool _loaded = false;

  final _diagnosisCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _followUpCtrl = TextEditingController();

  // Simple list of prescription items
  final List<Map<String, String>> _prescriptionItems = [];

  @override
  void dispose() {
    _diagnosisCtrl.dispose();
    _notesCtrl.dispose();
    _followUpCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadExisting() async {
    if (_loaded) return;
    _loaded = true;
    final db = ref.read(databaseProvider).requireValue;
    final c = await db.patientDao.getConsultation(widget.patientId);
    if (c == null || !mounted) return;
    setState(() {
      _diagnosisCtrl.text = c.diagnosis ?? '';
      _notesCtrl.text = c.clinicalNotes ?? '';
      _followUpCtrl.text = c.followUpDate ?? '';
      if (c.prescription != null) {
        final decoded = jsonDecode(c.prescription!) as List;
        _prescriptionItems.addAll(decoded.cast<Map<String, String>>());
      }
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final session = ref.read(sessionProvider).requireValue!;
      final db = ref.read(databaseProvider).requireValue;

      await db.patientDao.upsertConsultation(
        ConsultationsCompanion(
          patientId: Value(widget.patientId),
          diagnosis: Value(_diagnosisCtrl.text.trim().isEmpty ? null : _diagnosisCtrl.text.trim()),
          clinicalNotes: Value(_notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim()),
          prescription: Value(jsonEncode(_prescriptionItems)),
          followUpDate: Value(_followUpCtrl.text.trim().isEmpty ? null : _followUpCtrl.text.trim()),
        ),
        session.userId,
      );

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Consultation saved')));
        context.go(routeDashboard);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _addPrescriptionItem() {
    final nameCtrl = TextEditingController();
    final doseCtrl = TextEditingController();
    final durationCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add medicine'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Medicine name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: doseCtrl,
              decoration: const InputDecoration(labelText: 'Dose & frequency'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: durationCtrl,
              decoration: const InputDecoration(labelText: 'Duration'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (nameCtrl.text.trim().isNotEmpty) {
                setState(() => _prescriptionItems.add({
                      'name': nameCtrl.text.trim(),
                      'dose': doseCtrl.text.trim(),
                      'duration': durationCtrl.text.trim(),
                    }));
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _loadExisting();

    final patientAsync = ref.watch(patientProvider(widget.patientId));

    return Scaffold(
      appBar: AppBar(
        title: patientAsync.whenOrNull(
              data: (p) => Text(p?.fullName ?? 'Consultation'),
            ) ??
            const Text('Consultation'),
        actions: const [SyncStatusBadge(), SizedBox(width: 16)],
      ),
      body: RoleGuard(
        allowedRoles: [UserRole.doctor, UserRole.admin],
        fallback: _readOnlyView(),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _section('Diagnosis'),
              TextFormField(
                controller: _diagnosisCtrl,
                decoration: const InputDecoration(labelText: 'Diagnosis *'),
                maxLines: 2,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              _section('Clinical notes'),
              TextFormField(
                controller: _notesCtrl,
                decoration: const InputDecoration(labelText: 'Clinical notes'),
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              _section('Prescription'),
              ..._prescriptionItems.asMap().entries.map((e) => ListTile(
                    leading: const Icon(Icons.medication_outlined),
                    title: Text(e.value['name'] ?? ''),
                    subtitle: Text('${e.value['dose']} — ${e.value['duration']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () =>
                          setState(() => _prescriptionItems.removeAt(e.key)),
                    ),
                  )),
              TextButton.icon(
                onPressed: _addPrescriptionItem,
                icon: const Icon(Icons.add),
                label: const Text('Add medicine'),
              ),
              const SizedBox(height: 16),
              _section('Follow-up'),
              TextFormField(
                controller: _followUpCtrl,
                decoration: const InputDecoration(
                  labelText: 'Follow-up date',
                  hintText: 'YYYY-MM-DD',
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save consultation'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      );

  Widget _readOnlyView() {
    final consultAsync = ref.watch(consultationProvider(widget.patientId));
    return consultAsync.when(
      data: (c) => c == null
          ? const Center(child: Text('No consultation recorded yet'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _readRow('Diagnosis', c.diagnosis),
                _readRow('Notes', c.clinicalNotes),
                _readRow('Follow-up', c.followUpDate),
              ],
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _readRow(String label, String? value) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 4),
          Text(value ?? '—'),
        ]),
      );
}
