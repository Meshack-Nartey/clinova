import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/settings/settings_providers.dart';
import '../../shared/widgets/clinova_logo.dart';

class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  final _nameCtrl = TextEditingController();
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      setState(() => _error = 'Please enter your clinic or organisation name');
      return;
    }
    setState(() { _saving = true; _error = null; });
    await ref.read(clinicNameProvider.notifier).save(name);
    // Router will auto-redirect once clinicName is set
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ClinovaLogo(size: 72, foreground: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    'Clinova',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Offline patient records',
                    style: TextStyle(fontSize: 14, color: Color(0xFF888888)),
                  ),
                  const SizedBox(height: 48),

                  // Card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Welcome — let\'s get started',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111111),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Enter the name of your clinic or organisation. This appears on all patient records.',
                          style: TextStyle(fontSize: 13, color: Color(0xFF888888), height: 1.5),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _nameCtrl,
                          autofocus: true,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            labelText: 'Clinic / Organisation name',
                            hintText: 'e.g. Accra Community Clinic',
                            prefixIcon: Icon(Icons.local_hospital_outlined),
                          ),
                          onSubmitted: (_) => _submit(),
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: 8),
                          Row(children: [
                            const Icon(Icons.error_outline,
                                size: 15, color: Color(0xFFB00020)),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(_error!,
                                  style: const TextStyle(
                                      color: Color(0xFFB00020), fontSize: 13)),
                            ),
                          ]),
                        ],
                        const SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            width: 200,
                            height: 48,
                            child: FilledButton(
                              onPressed: _saving ? null : _submit,
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF111111),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: _saving
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2, color: Colors.white),
                                    )
                                  : const Text('Get started',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
