import 'dart:async';
import 'dart:io';

import 'package:record/record.dart';

class RecorderService {
  final Record _record = Record();
  bool _isRecording = false;
  String? _currentRecordingPath;

  bool get isRecording => _isRecording;
  String? get currentRecordingPath => _currentRecordingPath;

  Future<bool> startRecording(String outputPath) async {
    final hasPermission = await _record.hasPermission();
    if (!hasPermission) {
      return false;
    }

    _currentRecordingPath = outputPath;

    final started = await _record.start(
      path: outputPath,
      encoder: AudioEncoder.aacLc,
      bitRate: 128000,
      samplingRate: 44100,
    );

    _isRecording = started;
    return started;
  }

  Future<String?> stopRecording() async {
    if (!_isRecording) {
      return null;
    }

    final path = await _record.stop();
    _isRecording = false;
    final storedPath = _currentRecordingPath;
    _currentRecordingPath = null;
    return path ?? storedPath;
  }

  Future<void> dispose() async {
    if (_isRecording) {
      await _record.stop();
    }
    await _record.dispose();
  }
}
