import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../config/app_config.dart';
import '../../../core/services/recorder_service.dart';

class RecorderProvider extends ChangeNotifier {
  final RecorderService _recorderService = RecorderService();
  Timer? _timer;

  bool _isRecording = false;
  String? _currentRecordingPath;
  Duration _recordingDuration = Duration.zero;

  bool get isRecording => _isRecording;
  String? get currentRecordingPath => _currentRecordingPath;
  Duration get recordingDuration => _recordingDuration;

  Future<void> startRecording() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = 'recording_$timestamp.m4a';
    final outputPath = '${AppConfig.audioDirectory.path}/$fileName';

    final success = await _recorderService.startRecording(outputPath);
    if (!success) {
      return;
    }

    _isRecording = true;
    _currentRecordingPath = outputPath;
    _recordingDuration = Duration.zero;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _recordingDuration += const Duration(seconds: 1);
      notifyListeners();
    });

    notifyListeners();
  }

  Future<String?> stopRecording() async {
    _timer?.cancel();
    _timer = null;

    final path = await _recorderService.stopRecording();
    _isRecording = false;
    _currentRecordingPath = null;
    notifyListeners();
    return path;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recorderService.dispose();
    super.dispose();
  }
}
