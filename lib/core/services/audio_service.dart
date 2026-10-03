import 'package:audioplayers/audioplayers.dart';
import 'dart:io';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _recorderPlayer = AudioPlayer();

  Future<void> playAudio(String filePath) async {
    try {
      await _audioPlayer.play(DeviceFileSource(filePath));
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> stopPlayback() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      print('Error stopping playback: $e');
    }
  }

  Future<void> pausePlayback() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      print('Error pausing playback: $e');
    }
  }

  Stream<PlayerState> get playerStateStream => _audioPlayer.onPlayerStateChanged;
  Stream<Duration> get durationStream => _audioPlayer.onDurationChanged;
  Stream<Duration> get positionStream => _audioPlayer.onPositionChanged;

  Future<void> dispose() async {
    await _audioPlayer.dispose();
    await _recorderPlayer.dispose();
  }
}
