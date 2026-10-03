import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AppConfig {
  static late Directory _appDocDir;
  static late Directory _audioDir;

  static Future<void> initialize() async {
    _appDocDir = await getApplicationDocumentsDirectory();
    _audioDir = Directory('${_appDocDir.path}/audio_files');
    
    if (!await _audioDir.exists()) {
      await _audioDir.create(recursive: true);
    }
  }

  static Directory get audioDirectory => _audioDir;
  static Directory get appDirectory => _appDocDir;
}
