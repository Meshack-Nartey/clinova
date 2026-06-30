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

class LabScreen extends ConsumerStatefulWidget {
  final String patientId;
  const LabScreen({super.key, required this.patientId});

  @override
  ConsumerState<LabScreen> createState() => _LabScreenState();
}

class _LabScreenState extends ConsumerState<LabScreen> {
  final List<_TestEntry> _entries = [];
  bool _saving = false;

  Future<void> _load() async {
    final db = ref.read(databaseProvider).requireValue;
    final results = await db.patientDao.getLabResults(widget.patientId);
    if (!mounted) return;
    setState(() {
      _entries.clear();
      for (final r in results) {
        _entries.add(_TestEntry(
          id: r.id,
          testName: TextEditingController(text: r.testName ?? ''),
          result: TextEditingController(text: r.result ?? ''),
          reference: TextEditingController(text: r.referenceRange ?? ''),
        ));
      }
      if (_entries.isEmpty) _addRow();
    });
  }

  void _addRow() => setState(() => _entries.add(_TestEntry(
        testName: TextEditingController(),
        result: TextEditingController(),
        reference: TextEditingController(),
      )));

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final session = ref.read(sessionProvider).requireValue!;
      final db = ref.read(databaseProvider).requireValue;

      for (final e in _entries) {
        if (e.testName.text.trim().isEmpty) continue;
        await db.patientDao.upsertLabResult(
          LabResultsCompanion(
            id: e.id != null ? Value(e.id!) : const Value.absent(),
            patientId: Value(widget.patientId),
            testName: Value(e.testName.text.trim()),
            result: Value(e.result.text.trim().isEmpty ? null : e.result.text.trim()),
            referenceRange:
                Value(e.reference.text.trim().isEmpty ? null : e.reference.text.trim()),
          ),
          session.userId,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Lab results saved')));
        context.go(routeDashboard);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final patientAsync = ref.watch(patientProvider(widget.patientId));

    return Scaffold(
      appBar: AppBar(
        title: patientAsync.whenOrNull(data: (p) => Text(p?.fullName ?? 'Lab results')) ??
            const Text('Lab results'),
        actions: const [SyncStatusBadge(), SizedBox(width: 16)],
      ),
      body: RoleGuard(
        allowedRoles: [UserRole.lab, UserRole.admin],
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Test results',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            ..._entries.asMap().entries.map((entry) {
              final i = entry.key;
              final e = entry.value;
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                          child: TextFormField(
                            controller: e.testName,
                            decoration: const InputDecoration(labelText: 'Test name'),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => setState(() => _entries.removeAt(i)),
                        ),
                      ]),
                      const SizedBox(height: 8),
                      Row(children: [
                        Expanded(
                          child: TextFormField(
                            controller: e.result,
                            decoration: const InputDecoration(labelText: 'Result'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: e.reference,
                            decoration: const InputDecoration(labelText: 'Reference range'),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              );
            }),
            TextButton.icon(
              onPressed: _addRow,
              icon: const Icon(Icons.add),
              label: const Text('Add test'),
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
                  : const Text('Save lab results'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TestEntry {
  final String? id;
  final TextEditingController testName;
  final TextEditingController result;
  final TextEditingController reference;

  _TestEntry({this.id, required this.testName, required this.result, required this.reference});
}
