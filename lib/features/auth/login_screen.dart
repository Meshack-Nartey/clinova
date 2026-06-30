import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth/providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _nameController = TextEditingController();
  final _pinController = TextEditingController();
  bool _loading = false;
  bool _pinVisible = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    final pin = _pinController.text.trim();
    if (name.isEmpty || pin.isEmpty) {
      setState(() => _error = 'Enter your name and PIN');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await ref.read(sessionProvider.notifier).login(name, pin);
    } catch (e) {
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLow,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              child: Card(
                elevation: 2,
                shadowColor: colors.shadow.withValues(alpha: 0.15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header band
                    Container(
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: colors.onPrimary.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.local_hospital_rounded,
                              size: 42,
                              color: colors.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Clinova',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: colors.onPrimary,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Offline patient records',
                            style: TextStyle(
                              fontSize: 13,
                              color: colors.onPrimary.withValues(alpha: 0.75),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Form body
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Your name',
                              prefixIcon: const Icon(Icons.person_outline),
                              fillColor: colors.surfaceContainerHighest,
                            ),
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.name],
                          ),
                          const SizedBox(height: 14),
                          TextField(
                            controller: _pinController,
                            decoration: InputDecoration(
                              labelText: 'PIN',
                              prefixIcon: const Icon(Icons.lock_outline),
                              fillColor: colors.surfaceContainerHighest,
                              suffixIcon: IconButton(
                                icon: Icon(_pinVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined),
                                onPressed: () =>
                                    setState(() => _pinVisible = !_pinVisible),
                              ),
                            ),
                            obscureText: !_pinVisible,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _submit(),
                          ),
                          if (_error != null) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.error_outline,
                                    size: 16, color: colors.error),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    _error!,
                                    style: TextStyle(
                                        color: colors.error, fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 20),
                          FilledButton(
                            onPressed: _loading ? null : _submit,
                            child: _loading
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: Colors.white),
                                  )
                                : const Text('Sign in'),
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
      ),
    );
  }
}
