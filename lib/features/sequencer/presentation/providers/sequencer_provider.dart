import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../core/models/audio_track.dart';
import '../../../../core/services/audio_service.dart';

class SequencerProvider extends ChangeNotifier {
  final AudioService _audioService = AudioService();
  final List<AudioTrack> _tracks = [];
  Timer? _playTimer;

  bool _isPlaying = false;
  int _currentBPM = 120;
  int _currentTrackIndex = 0;

  List<AudioTrack> get tracks => _tracks;
  bool get isPlaying => _isPlaying;
  int get currentBPM => _currentBPM;

  void addTrack(AudioTrack track) {
    _tracks.add(track);
    notifyListeners();
  }

  void addTrackFromFile(String filePath, {String? customName}) {
    final safeName = customName ?? 'Track ${_tracks.length + 1}';
    final track = AudioTrack(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: safeName,
      filePath: filePath,
      duration: const Duration(seconds: 8),
      order: _tracks.length,
    );
    addTrack(track);
  }

  void removeTrack(String trackId) {
    _tracks.removeWhere((track) => track.id == trackId);
    notifyListeners();
  }

  Future<void> playSequence() async {
    if (_tracks.isEmpty) {
      return;
    }

    _isPlaying = true;
    _currentTrackIndex = 0;
    notifyListeners();

    _playTimer?.cancel();
    final interval = Duration(milliseconds: (60000 / _currentBPM).round());

    _playTimer = Timer.periodic(interval, (_) {
      if (_tracks.isEmpty) {
        return;
      }

      final track = _tracks[_currentTrackIndex];
      _audioService.playAudio(track.filePath);
      _currentTrackIndex = (_currentTrackIndex + 1) % _tracks.length;
      notifyListeners();
    });
  }

  Future<void> stopSequence() async {
    _isPlaying = false;
    _playTimer?.cancel();
    _playTimer = null;
    await _audioService.stopPlayback();
    notifyListeners();
  }

  void setBPM(int bpm) {
    if (bpm <= 0) {
      return;
    }

    _currentBPM = bpm;
    notifyListeners();
  }

  @override
  void dispose() {
    _playTimer?.cancel();
    _audioService.dispose();
    super.dispose();
  }
}
