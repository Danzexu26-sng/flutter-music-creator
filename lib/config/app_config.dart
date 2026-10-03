import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AppConfig {
  static late final Directory _appDocDir;
  static late final Directory _audioDir;

  static Future<void> initialize() async {
    _appDocDir = await getApplicationDocumentsDirectory();
    _audioDir = Directory('${_appDocDir.path}/audio_files');

    if (!await _audioDir.exists()) {
      await _audioDir.create(recursive: true);
    }
  }

  static Directory get appDirectory => _appDocDir;
  static Directory get audioDirectory => _audioDir;
}
