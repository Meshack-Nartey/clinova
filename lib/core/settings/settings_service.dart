import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class SettingsService {
  static const _fileName = 'clinova_settings.json';

  Future<File> get _file async {
    final dir = await getApplicationSupportDirectory();
    return File(p.join(dir.path, _fileName));
  }

  Future<Map<String, dynamic>> _read() async {
    final f = await _file;
    if (!await f.exists()) return {};
    try {
      return jsonDecode(await f.readAsString()) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }

  Future<void> _write(Map<String, dynamic> data) async {
    final f = await _file;
    await f.writeAsString(jsonEncode(data));
  }

  Future<String?> getClinicName() async {
    final data = await _read();
    return data['clinicName'] as String?;
  }

  Future<void> setClinicName(String name) async {
    final data = await _read();
    data['clinicName'] = name;
    await _write(data);
  }
}
