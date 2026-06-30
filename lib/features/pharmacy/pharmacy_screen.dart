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

class PharmacyScreen extends ConsumerStatefulWidget {
  final String patientId;
  const PharmacyScreen({super.key, required this.patientId});

  @override
  ConsumerState<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends ConsumerState<PharmacyScreen> {
  final _notesCtrl = TextEditingController();
  final List<Map<String, String>> _dispensed = [];
  bool _saving = false;
  bool _loaded = false;

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    if (_loaded) return;
    _loaded = true;
    final db = ref.read(databaseProvider).requireValue;
    final r = await db.patientDao.getDispensingRecord(widget.patientId);
    if (r == null || !mounted) return;
    setState(() {
      _notesCtrl.text = r.counsellingNotes ?? '';
      if (r.itemsDispensed != null) {
        final decoded = jsonDecode(r.itemsDispensed!) as List;
        _dispensed.addAll(decoded.cast<Map<String, String>>());
      }
    });
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final session = ref.read(sessionProvider).requireValue!;
      final db = ref.read(databaseProvider).requireValue;

      await db.patientDao.upsertDispensingRecord(
        DispensingRecordsCompanion(
          patientId: Value(widget.patientId),
          itemsDispensed: Value(jsonEncode(_dispensed)),
          counsellingNotes:
              Value(_notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim()),
        ),
        session.userId,
      );

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Dispensing record saved')));
        context.go(routeDashboard);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _addItem() {
    final nameCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Dispense item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Medicine name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: qtyCtrl,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              if (nameCtrl.text.trim().isNotEmpty) {
                setState(() => _dispensed.add({
                      'name': nameCtrl.text.trim(),
                      'qty': qtyCtrl.text.trim(),
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
    _load();
    final patientAsync = ref.watch(patientProvider(widget.patientId));
    final consultAsync = ref.watch(consultationProvider(widget.patientId));

    return Scaffold(
      appBar: AppBar(
        title: patientAsync.whenOrNull(data: (p) => Text(p?.fullName ?? 'Pharmacy')) ??
            const Text('Pharmacy'),
        actions: const [SyncStatusBadge(), SizedBox(width: 16)],
      ),
      body: RoleGuard(
        allowedRoles: [UserRole.pharmacist, UserRole.admin],
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Read-only prescription from doctor
            consultAsync.when(
              data: (c) {
                if (c?.prescription == null) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('No prescription recorded by doctor yet.'),
                    ),
                  );
                }
                final items = jsonDecode(c!.prescription!) as List;
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
                        child: Text('Prescription',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      ...items.map((item) {
                        final m = item as Map<String, dynamic>;
                        return ListTile(
                          dense: true,
                          leading: const Icon(Icons.medication_outlined),
                          title: Text(m['name'] ?? ''),
                          subtitle: Text('${m['dose']} — ${m['duration']}'),
                        );
                      }),
                    ],
                  ),
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('Error: $e'),
            ),
            const SizedBox(height: 16),
            const Text('Items dispensed',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            ..._dispensed.asMap().entries.map((e) => ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(e.value['name'] ?? ''),
                  subtitle: Text('Qty: ${e.value['qty']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => setState(() => _dispensed.removeAt(e.key)),
                  ),
                )),
            TextButton.icon(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
              label: const Text('Add dispensed item'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesCtrl,
              decoration: const InputDecoration(labelText: 'Counselling notes'),
              maxLines: 4,
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
                  : const Text('Save dispensing record'),
            ),
          ],
        ),
      ),
    );
  }
}
