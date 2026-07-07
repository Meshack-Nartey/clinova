import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth/encryption.dart';
import '../../shared/routing/router.dart';
import '../../core/auth/providers.dart';
import '../../core/database/app_database.dart';
import '../../core/database/tables.dart';

// ---------------------------------------------------------------------------
// Provider
// ---------------------------------------------------------------------------

final _staffProvider = StreamProvider<List<User>>((ref) {
  final db = ref.watch(databaseProvider).requireValue;
  return db.userDao.watchAllUsers();
});

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

class StaffScreen extends ConsumerWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(_staffProvider);
    final session = ref.watch(sessionProvider).valueOrNull;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text('Manage Staff'),
        leading: BackButton(onPressed: () => context.go(routeDashboard)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilledButton.icon(
              onPressed: () => _showAddSheet(context, ref),
              icon: const Icon(Icons.person_add_rounded, size: 18),
              label: const Text('Add staff'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF111111),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                minimumSize: const Size(0, 36),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
      body: staffAsync.when(
        data: (staff) {
          if (staff.isEmpty) {
            return const Center(
              child: Text('No staff yet. Tap "Add staff" to register the first worker.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF888888), fontSize: 14)),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            itemCount: staff.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              final user = staff[i];
              final isSelf = user.id == session?.userId;
              return _StaffCard(
                user: user,
                isSelf: isSelf,
                onResetPin: () => _showResetPinSheet(context, ref, user),
                onDelete: isSelf
                    ? null
                    : () => _confirmDelete(context, ref, user),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  void _showAddSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _AddStaffSheet(ref: ref),
    );
  }

  void _showResetPinSheet(BuildContext context, WidgetRef ref, User user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _ResetPinSheet(ref: ref, user: user),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref, User user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Remove staff member?'),
        content: Text('${user.name} will no longer be able to sign in.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFFB00020)),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final db = ref.read(databaseProvider).requireValue;
      await db.userDao.deleteUser(user.id);
    }
  }
}

// ---------------------------------------------------------------------------
// Staff card
// ---------------------------------------------------------------------------

class _StaffCard extends StatelessWidget {
  final User user;
  final bool isSelf;
  final VoidCallback onResetPin;
  final VoidCallback? onDelete;

  const _StaffCard({
    required this.user,
    required this.isSelf,
    required this.onResetPin,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final role = UserRole.values.firstWhere((r) => r.name == user.roleValue,
        orElse: () => UserRole.nurse);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
                user.name.trim().split(' ').take(2).map((w) => w[0]).join().toUpperCase(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(user.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Color(0xFF111111))),
                    if (isSelf) ...[
                      const SizedBox(width: 6),
                      const Text('(you)',
                          style: TextStyle(fontSize: 12, color: Color(0xFF888888))),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                _RolePill(role: role),
              ],
            ),
          ),
          PopupMenuButton<_StaffAction>(
            icon: const Icon(Icons.more_vert_rounded, color: Color(0xFFAAAAAA)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onSelected: (action) {
              if (action == _StaffAction.resetPin) onResetPin();
              if (action == _StaffAction.delete) onDelete?.call();
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: _StaffAction.resetPin,
                child: Row(children: [
                  Icon(Icons.lock_reset_rounded, size: 18),
                  SizedBox(width: 10),
                  Text('Reset PIN'),
                ]),
              ),
              if (onDelete != null)
                const PopupMenuItem(
                  value: _StaffAction.delete,
                  child: Row(children: [
                    Icon(Icons.person_remove_rounded, size: 18, color: Color(0xFFB00020)),
                    SizedBox(width: 10),
                    Text('Remove', style: TextStyle(color: Color(0xFFB00020))),
                  ]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _StaffAction { resetPin, delete }

// ---------------------------------------------------------------------------
// Role pill
// ---------------------------------------------------------------------------

class _RolePill extends StatelessWidget {
  final UserRole role;
  const _RolePill({required this.role});

  String get _label => switch (role) {
        UserRole.nurse => 'Nurse',
        UserRole.doctor => 'Doctor',
        UserRole.pharmacist => 'Pharmacist',
        UserRole.lab => 'Lab Tech',
        UserRole.admin => 'Admin',
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: role == UserRole.admin
            ? const Color(0xFF111111)
            : const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: role == UserRole.admin
              ? Colors.white
              : const Color(0xFF555555),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Add staff sheet
// ---------------------------------------------------------------------------

class _AddStaffSheet extends StatefulWidget {
  final WidgetRef ref;
  const _AddStaffSheet({required this.ref});

  @override
  State<_AddStaffSheet> createState() => _AddStaffSheetState();
}

class _AddStaffSheetState extends State<_AddStaffSheet> {
  final _nameCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  UserRole _role = UserRole.nurse;
  bool _loading = false;
  String? _error;
  bool _pinVisible = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _pinCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameCtrl.text.trim();
    final pin = _pinCtrl.text.trim();
    final confirm = _confirmCtrl.text.trim();

    if (name.isEmpty) return setState(() => _error = 'Enter a name');
    if (pin.length < 4) return setState(() => _error = 'PIN must be at least 4 digits');
    if (pin != confirm) return setState(() => _error = 'PINs do not match');

    setState(() { _loading = true; _error = null; });

    try {
      final db = widget.ref.read(databaseProvider).requireValue;
      final existing = await db.userDao.getUserByName(name);
      if (existing != null) {
        setState(() => _error = 'A staff member with that name already exists');
        return;
      }
      final pinHash = await hashPin(pin);
      await db.userDao.createUser(name: name, role: _role, pinHash: pinHash);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SheetHandle(),
          const SizedBox(height: 4),
          const Text('Add staff member',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF111111))),
          const SizedBox(height: 20),
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(labelText: 'Full name', prefixIcon: Icon(Icons.person_outline_rounded)),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<UserRole>(
            value: _role,
            decoration: const InputDecoration(labelText: 'Role', prefixIcon: Icon(Icons.badge_outlined)),
            items: UserRole.values.map((r) {
              final label = switch (r) {
                UserRole.nurse => 'Nurse',
                UserRole.doctor => 'Doctor',
                UserRole.pharmacist => 'Pharmacist',
                UserRole.lab => 'Lab Tech',
                UserRole.admin => 'Admin',
              };
              return DropdownMenuItem(value: r, child: Text(label));
            }).toList(),
            onChanged: (v) => setState(() => _role = v ?? _role),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _pinCtrl,
            decoration: InputDecoration(
              labelText: 'PIN',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                icon: Icon(_pinVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                onPressed: () => setState(() => _pinVisible = !_pinVisible),
              ),
            ),
            obscureText: !_pinVisible,
            keyboardType: TextInputType.number,
            maxLength: 6,
          ),
          const SizedBox(height: 4),
          TextField(
            controller: _confirmCtrl,
            decoration: const InputDecoration(
              labelText: 'Confirm PIN',
              prefixIcon: Icon(Icons.lock_outline_rounded),
            ),
            obscureText: !_pinVisible,
            keyboardType: TextInputType.number,
            maxLength: 6,
          ),
          if (_error != null) ...[
            const SizedBox(height: 4),
            Row(children: [
              const Icon(Icons.error_outline, size: 15, color: Color(0xFFB00020)),
              const SizedBox(width: 6),
              Expanded(child: Text(_error!, style: const TextStyle(color: Color(0xFFB00020), fontSize: 13))),
            ]),
          ],
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _loading ? null : _submit,
            child: _loading
                ? const SizedBox(height: 20, width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Register staff member'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reset PIN sheet
// ---------------------------------------------------------------------------

class _ResetPinSheet extends StatefulWidget {
  final WidgetRef ref;
  final User user;
  const _ResetPinSheet({required this.ref, required this.user});

  @override
  State<_ResetPinSheet> createState() => _ResetPinSheetState();
}

class _ResetPinSheetState extends State<_ResetPinSheet> {
  final _pinCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _loading = false;
  String? _error;
  bool _pinVisible = false;

  @override
  void dispose() {
    _pinCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final pin = _pinCtrl.text.trim();
    final confirm = _confirmCtrl.text.trim();

    if (pin.length < 4) return setState(() => _error = 'PIN must be at least 4 digits');
    if (pin != confirm) return setState(() => _error = 'PINs do not match');

    setState(() { _loading = true; _error = null; });

    try {
      final db = widget.ref.read(databaseProvider).requireValue;
      final pinHash = await hashPin(pin);
      await db.userDao.updateUserPin(widget.user.id, pinHash);
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PIN updated for ${widget.user.name}')),
        );
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SheetHandle(),
          const SizedBox(height: 4),
          Text('Reset PIN — ${widget.user.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF111111))),
          const SizedBox(height: 20),
          TextField(
            controller: _pinCtrl,
            decoration: InputDecoration(
              labelText: 'New PIN',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                icon: Icon(_pinVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                onPressed: () => setState(() => _pinVisible = !_pinVisible),
              ),
            ),
            obscureText: !_pinVisible,
            keyboardType: TextInputType.number,
            maxLength: 6,
          ),
          const SizedBox(height: 4),
          TextField(
            controller: _confirmCtrl,
            decoration: const InputDecoration(
              labelText: 'Confirm new PIN',
              prefixIcon: Icon(Icons.lock_outline_rounded),
            ),
            obscureText: !_pinVisible,
            keyboardType: TextInputType.number,
            maxLength: 6,
          ),
          if (_error != null) ...[
            const SizedBox(height: 4),
            Row(children: [
              const Icon(Icons.error_outline, size: 15, color: Color(0xFFB00020)),
              const SizedBox(width: 6),
              Expanded(child: Text(_error!, style: const TextStyle(color: Color(0xFFB00020), fontSize: 13))),
            ]),
          ],
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _loading ? null : _submit,
            child: _loading
                ? const SizedBox(height: 20, width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Update PIN'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared handle widget
// ---------------------------------------------------------------------------

class _SheetHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      children: [
        Container(
          width: 36, height: 4,
          decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(height: 16),
      ],
    ),
  );
}
