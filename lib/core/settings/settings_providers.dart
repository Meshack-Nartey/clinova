import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_service.dart';

final settingsServiceProvider = Provider<SettingsService>((_) => SettingsService());

final clinicNameProvider =
    StateNotifierProvider<ClinicNameNotifier, AsyncValue<String?>>((ref) {
  return ClinicNameNotifier(ref.watch(settingsServiceProvider));
});

class ClinicNameNotifier extends StateNotifier<AsyncValue<String?>> {
  final SettingsService _service;

  ClinicNameNotifier(this._service) : super(const AsyncLoading()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final name = await _service.getClinicName();
      state = AsyncData(name);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> save(String name) async {
    await _service.setClinicName(name.trim());
    state = AsyncData(name.trim());
  }
}
