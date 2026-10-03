import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/services/recorder_service.dart';
import '../../../../config/app_config.dart';
import 'dart:io';

class RecorderProvider extends ChangeNotifier {
  final RecorderService _recorderService = RecorderService();
  bool _isRecording = false;
  String? _currentRecordingPath;
  Duration _recordingDuration = Duration.zero;

  bool get isRecording => _isRecording;
  String? get currentRecordingPath => _currentRecordingPath;
  Duration get recordingDuration => _recordingDuration;

  Future<void> startRecording() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = 'recording_$timestamp.wav';
    final outputPath = '${AppConfig.audioDirectory.path}/$fileName';

    final success = await _recorderService.startRecording(outputPath);
    if (success) {
      _isRecording = true;
      _currentRecordingPath = outputPath;
      _recordingDuration = Duration.zero;
      notifyListeners();
    }
  }

  Future<String?> stopRecording() async {
    final path = await _recorderService.stopRecording();
    _isRecording = false;
    _currentRecordingPath = null;
    notifyListeners();
    return path;
  }

  void updateRecordingDuration(Duration duration) {
    _recordingDuration = duration;
    notifyListeners();
  }

  @override
  void dispose() {
    _recorderService.dispose();
    super.dispose();
  }
}
