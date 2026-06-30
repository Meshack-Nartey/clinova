import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/sync/sync_providers.dart';

/// Shown as a bottom sheet from the dashboard action menu.
/// Allows starting hub mode or connecting a client to a hub.
class HubSetupSheet extends ConsumerStatefulWidget {
  final bool canStartHub;
  const HubSetupSheet({super.key, this.canStartHub = false});

  @override
  ConsumerState<HubSetupSheet> createState() => _HubSetupSheetState();
}

class _HubSetupSheetState extends ConsumerState<HubSetupSheet> {
  final _ipCtrl = TextEditingController();
  bool _connecting = false;
  String? _error;
  String? _hubIp;

  @override
  void dispose() {
    _ipCtrl.dispose();
    super.dispose();
  }

  Future<void> _startHub() async {
    try {
      await ref.read(hubServerProvider.notifier).start();
      final ip = await _getLocalIp();
      if (mounted) setState(() => _hubIp = ip);
    } catch (e) {
      setState(() => _error = 'Failed to start hub: $e');
    }
  }

  Future<String> _getLocalIp() async {
    final interfaces = await NetworkInterface.list(type: InternetAddressType.IPv4);
    for (final iface in interfaces) {
      for (final addr in iface.addresses) {
        if (!addr.isLoopback) return addr.address;
      }
    }
    return 'unknown';
  }

  Future<void> _stopHub() async {
    await ref.read(hubServerProvider.notifier).stop();
    if (mounted) Navigator.pop(context);
  }

  Future<void> _connectToHub() async {
    final ip = _ipCtrl.text.trim();
    if (ip.isEmpty) {
      setState(() => _error = 'Enter the hub IP address');
      return;
    }
    setState(() {
      _connecting = true;
      _error = null;
    });
    try {
      // Quick ping to verify hub is reachable
      final uri = Uri.parse('http://$ip:8765/hub-info');
      final response = await HttpClient()
          .getUrl(uri)
          .then((req) => req.close())
          .timeout(const Duration(seconds: 4));
      if (response.statusCode != 200) throw Exception('Hub not reachable');

      await ref.read(syncClientProvider.notifier).connect('http://$ip:8765');
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => _error = 'Cannot reach hub at $ip — check the IP and Wi-Fi');
    } finally {
      if (mounted) setState(() => _connecting = false);
    }
  }

  Future<void> _disconnect() async {
    await ref.read(syncClientProvider.notifier).disconnect();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isHub = ref.watch(isHubModeProvider);
    final client = ref.watch(syncClientProvider);

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Network setup',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            'All devices must be on the same Wi-Fi network.',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
          const SizedBox(height: 24),

          // Hub section — only for admin/doctor
          if (widget.canStartHub) ...[
            const Text('Hub (laptop / main device)',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (!isHub)
              ElevatedButton.icon(
                onPressed: _startHub,
                icon: const Icon(Icons.hub_outlined),
                label: const Text('Start as hub'),
              )
            else ...[
              if (_hubIp != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.wifi, color: Colors.blue, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Hub running — share this IP:',
                                style: TextStyle(fontSize: 12, color: Colors.blue)),
                            Text('$_hubIp:8765',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18),
                        tooltip: 'Copy IP',
                        onPressed: () =>
                            Clipboard.setData(ClipboardData(text: _hubIp!)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
              OutlinedButton.icon(
                onPressed: _stopHub,
                icon: const Icon(Icons.stop_circle_outlined),
                label: const Text('Stop hub'),
              ),
            ],
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
          ],

          // Client section
          const Text('Client (phone / tablet)',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _ipCtrl,
            decoration: const InputDecoration(
              labelText: 'Hub IP address',
              hintText: 'e.g. 192.168.4.1',
              prefixIcon: Icon(Icons.router_outlined),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          if (client == null)
            ElevatedButton.icon(
              onPressed: _connecting ? null : _connectToHub,
              icon: _connecting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.link),
              label: const Text('Connect to hub'),
            )
          else
            OutlinedButton.icon(
              onPressed: _disconnect,
              icon: const Icon(Icons.link_off),
              label: const Text('Disconnect'),
            ),

          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 13)),
          ],
        ],
      ),
    );
  }
}
