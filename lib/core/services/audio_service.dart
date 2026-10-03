import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAudio(String filePath) async {
    try {
      await _audioPlayer.play(DeviceFileSource(filePath));
    } catch (error) {
      if (kDebugMode) {
        print('Audio playback error: $error');
      }
    }
  }

  Future<void> stopPlayback() async {
    try {
      await _audioPlayer.stop();
    } catch (error) {
      if (kDebugMode) {
        print('Stop playback error: $error');
      }
    }
  }

  Future<void> pausePlayback() async {
    try {
      await _audioPlayer.pause();
    } catch (error) {
      if (kDebugMode) {
        print('Pause playback error: $error');
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
