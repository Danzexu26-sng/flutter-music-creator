import 'package:audioplayers/audioplayers.dart';
import 'dart:io';

class RecorderService {
  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;
  String? _currentRecordingPath;

  bool get isRecording => _isRecording;
  String? get currentRecordingPath => _currentRecordingPath;

  Future<bool> startRecording(String outputPath) async {
    try {
      if (await _recorder.hasPermission()) {
        _currentRecordingPath = outputPath;
        await _recorder.start(
          RecordingAudioFormat.wav,
          path: outputPath,
        );
        _isRecording = true;
        return true;
      } else {
        print('Microphone permission denied');
        return false;
      }
    } catch (e) {
      print('Error starting recording: $e');
      return false;
    }
  }

  Future<String?> stopRecording() async {
    try {
      if (_isRecording) {
        final path = await _recorder.stop();
        _isRecording = false;
        return path;
      }
    } catch (e) {
      print('Error stopping recording: $e');
    }
    return null;
  }

  Future<void> dispose() async {
    if (_isRecording) {
      await stopRecording();
    }
    await _recorder.dispose();
  }
}
