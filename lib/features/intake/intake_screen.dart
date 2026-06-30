import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/auth/providers.dart';
import '../../core/database/app_database.dart';
import '../../shared/routing/router.dart';
import '../../shared/widgets/sync_status_badge.dart';
import '../dashboard/hub_setup_screen.dart';

class IntakeScreen extends ConsumerStatefulWidget {
  final String? patientId;
  const IntakeScreen({super.key, required this.patientId});

  @override
  ConsumerState<IntakeScreen> createState() => _IntakeScreenState();
}

class _IntakeScreenState extends ConsumerState<IntakeScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  final _nameCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _communityCtrl = TextEditingController();
  final _complaintCtrl = TextEditingController();
  String? _sex;

  final _bpCtrl = TextEditingController();
  final _tempCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _pulseCtrl = TextEditingController();
  final _spo2Ctrl = TextEditingController();

  bool _loaded = false;

  @override
  void dispose() {
    for (final c in [
      _nameCtrl, _dobCtrl, _phoneCtrl, _communityCtrl, _complaintCtrl,
      _bpCtrl, _tempCtrl, _weightCtrl, _heightCtrl, _pulseCtrl, _spo2Ctrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _loadExisting(String patientId) async {
    if (_loaded) return;
    _loaded = true;
    final db = ref.read(databaseProvider).requireValue;
    final p = await db.patientDao.getPatient(patientId);
    if (p == null || !mounted) return;
    setState(() {
      _nameCtrl.text = p.fullName;
      _dobCtrl.text = p.dateOfBirth ?? '';
      _phoneCtrl.text = p.phone ?? '';
      _communityCtrl.text = p.community ?? '';
      _complaintCtrl.text = p.chiefComplaint ?? '';
      _sex = p.sex;
      _bpCtrl.text = p.bloodPressure ?? '';
      _tempCtrl.text = p.temperatureCelsius?.toString() ?? '';
      _weightCtrl.text = p.weightKg?.toString() ?? '';
      _heightCtrl.text = p.heightCm?.toString() ?? '';
      _pulseCtrl.text = p.pulsePerMin?.toString() ?? '';
      _spo2Ctrl.text = p.spo2Percent?.toString() ?? '';
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    try {
      final session = ref.read(sessionProvider).requireValue!;
      final db = ref.read(databaseProvider).requireValue;
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final data = PatientsCompanion(
        sessionDate: Value(today),
        fullName: Value(_nameCtrl.text.trim()),
        dateOfBirth: Value(_dobCtrl.text.trim().isEmpty ? null : _dobCtrl.text.trim()),
        sex: Value(_sex),
        phone: Value(_phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim()),
        community: Value(_communityCtrl.text.trim().isEmpty ? null : _communityCtrl.text.trim()),
        chiefComplaint: Value(_complaintCtrl.text.trim().isEmpty ? null : _complaintCtrl.text.trim()),
        bloodPressure: Value(_bpCtrl.text.trim().isEmpty ? null : _bpCtrl.text.trim()),
        temperatureCelsius: Value(double.tryParse(_tempCtrl.text)),
        weightKg: Value(double.tryParse(_weightCtrl.text)),
        heightCm: Value(double.tryParse(_heightCtrl.text)),
        pulsePerMin: Value(int.tryParse(_pulseCtrl.text)),
        spo2Percent: Value(double.tryParse(_spo2Ctrl.text)),
      );

      if (widget.patientId == null) {
        await db.patientDao.createPatient(data, session.userId);
      } else {
        await db.patientDao.updatePatient(widget.patientId!, data, session.userId);
      }

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Patient record saved')));
        context.go(routeDashboard);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.patientId != null) _loadExisting(widget.patientId!);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patientId == null ? 'New Patient' : 'Edit Patient'),
        actions: [
          const SyncStatusBadge(),
          IconButton(
            icon: const Icon(Icons.hub_outlined),
            tooltip: 'Network setup',
            onPressed: () => showDialog(
              context: context,
              builder: (_) => Dialog(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: const HubSetupSheet(),
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
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _sectionHeader('Demographics'),

            // Name: letters, spaces, hyphens and apostrophes only
            _field(
              'Full name *',
              _nameCtrl,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s\-\']")),
              ],
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            _dobField(),
            const SizedBox(height: 12),
            _sexDropdown(),
            const SizedBox(height: 12),

            // Phone: digits, spaces, +, -, ()
            _field(
              'Phone number',
              _phoneCtrl,
              keyboard: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d\s\+\-\(\)]')),
              ],
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                final digits = v.replaceAll(RegExp(r'\D'), '');
                if (digits.length < 7) return 'Enter a valid phone number';
                return null;
              },
            ),
            const SizedBox(height: 12),

            _field('Community / village', _communityCtrl),
            const SizedBox(height: 12),

            _field(
              'Chief complaint *',
              _complaintCtrl,
              maxLines: 3,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 24),

            _sectionHeader('Vitals'),

            // Blood pressure: digits and / only, format NNN/NN
            _field(
              'Blood pressure (mmHg)',
              _bpCtrl,
              hint: 'e.g. 120/80',
              keyboard: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d\/]')),
                LengthLimitingTextInputFormatter(7),
              ],
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                if (!RegExp(r'^\d{2,3}\/\d{2,3}$').hasMatch(v.trim())) {
                  return 'Use format 120/80';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            Row(children: [
              // Temperature: decimal, range 30–45 °C
              Expanded(
                child: _field(
                  'Temp (°C)',
                  _tempCtrl,
                  keyboard: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d\.]')),
                    _SingleDotFormatter(),
                  ],
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null;
                    final n = double.tryParse(v);
                    if (n == null) return 'Invalid';
                    if (n < 30 || n > 45) return '30–45 °C';
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              // SpO₂: decimal, range 0–100 %
              Expanded(
                child: _field(
                  'SpO₂ (%)',
                  _spo2Ctrl,
                  keyboard: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d\.]')),
                    _SingleDotFormatter(),
                  ],
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null;
                    final n = double.tryParse(v);
                    if (n == null) return 'Invalid';
                    if (n < 0 || n > 100) return '0–100 %';
                    return null;
                  },
                ),
              ),
            ]),
            const SizedBox(height: 12),

            Row(children: [
              // Weight: positive decimal
              Expanded(
                child: _field(
                  'Weight (kg)',
                  _weightCtrl,
                  keyboard: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d\.]')),
                    _SingleDotFormatter(),
                  ],
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null;
                    final n = double.tryParse(v);
                    if (n == null || n <= 0) return 'Invalid';
                    if (n > 500) return 'Too high';
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              // Height: positive decimal
              Expanded(
                child: _field(
                  'Height (cm)',
                  _heightCtrl,
                  keyboard: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d\.]')),
                    _SingleDotFormatter(),
                  ],
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null;
                    final n = double.tryParse(v);
                    if (n == null || n <= 0) return 'Invalid';
                    if (n > 300) return 'Too high';
                    return null;
                  },
                ),
              ),
            ]),
            const SizedBox(height: 12),

            // Pulse: integer only, range 20–300 bpm
            _field(
              'Pulse (bpm)',
              _pulseCtrl,
              keyboard: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                final n = int.tryParse(v);
                if (n == null) return 'Invalid';
                if (n < 20 || n > 300) return '20–300 bpm';
                return null;
              },
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
                  : const Text('Save patient record'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Text(title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: colors.primary,
              )),
        ],
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController ctrl, {
    TextInputType keyboard = TextInputType.text,
    String? hint,
    int maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: ctrl,
        decoration: InputDecoration(labelText: label, hintText: hint),
        keyboardType: keyboard,
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        validator: validator,
      );

  Widget _dobField() => TextFormField(
        controller: _dobCtrl,
        decoration: const InputDecoration(
          labelText: 'Date of birth',
          hintText: 'YYYY-MM-DD',
          suffixIcon: Icon(Icons.calendar_today_outlined),
        ),
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          final picked = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            _dobCtrl.text = DateFormat('yyyy-MM-dd').format(picked);
          }
        },
        readOnly: true,
      );

  // ValueKey forces a new widget when _sex changes so initialValue stays in sync.
  Widget _sexDropdown() => DropdownButtonFormField<String>(
        key: ValueKey(_sex),
        initialValue: _sex,
        decoration: const InputDecoration(labelText: 'Sex'),
        items: const [
          DropdownMenuItem(value: 'Male', child: Text('Male')),
          DropdownMenuItem(value: 'Female', child: Text('Female')),
          DropdownMenuItem(value: 'Other', child: Text('Other')),
        ],
        onChanged: (v) => setState(() => _sex = v),
      );
}

/// Prevents a second decimal point from being entered.
class _SingleDotFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue old, TextEditingValue next) {
    final dots = next.text.split('.').length - 1;
    if (dots > 1) return old;
    return next;
  }
}
