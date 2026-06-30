import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/sync/sync_providers.dart';

class SyncStatusBadge extends ConsumerWidget {
  const SyncStatusBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHub = ref.watch(isHubModeProvider);
    if (isHub) return _Dot(color: Colors.blue, label: 'Hub on', animate: false);

    final status = ref.watch(syncStatusProvider);
    return switch (status) {
      SyncStatus.live => _Dot(color: Colors.green, label: 'Synced', animate: false),
      SyncStatus.syncing => _Dot(color: Colors.orange, label: 'Syncing…', animate: true),
      SyncStatus.error => _Dot(color: Colors.red, label: 'Offline', animate: false),
      SyncStatus.disabled => _Dot(color: Colors.grey, label: 'No hub', animate: false),
    };
  }
}

class _Dot extends StatefulWidget {
  final Color color;
  final String label;
  final bool animate;

  const _Dot({required this.color, required this.label, required this.animate});

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _opacity = Tween(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
    if (widget.animate) _ctrl.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(_Dot old) {
    super.didUpdateWidget(old);
    if (widget.animate && !_ctrl.isAnimating) {
      _ctrl.repeat(reverse: true);
    } else if (!widget.animate && _ctrl.isAnimating) {
      _ctrl.stop();
      _ctrl.value = 1.0;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeTransition(
            opacity: _opacity,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
            ),
          ),
          const SizedBox(width: 6),
          Text(widget.label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
