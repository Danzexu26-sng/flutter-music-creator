import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAudio(String filePath) async {
    try {
      await _audioPlayer.play(DeviceFileSource(filePath));
    } catch (e) {
      if (kDebugMode) {
        print('Audio playback error: $e');
      }
    }
  }

  Future<void> stopPlayback() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      if (kDebugMode) {
        print('Stop playback error: $e');
      }
    }
  }

  Future<void> pausePlayback() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      if (kDebugMode) {
        print('Pause playback error: $e');
      }
    }
  }

  Stream<PlayerState> get playerStateStream => _audioPlayer.onPlayerStateChanged;
  Stream<Duration> get durationStream => _audioPlayer.onDurationChanged;
  Stream<Duration> get positionStream => _audioPlayer.onPositionChanged;

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
