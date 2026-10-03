import 'package:flutter/foundation.dart';
import '../../../../core/models/audio_track.dart';
import '../../../../core/services/audio_service.dart';

class SequencerProvider extends ChangeNotifier {
  final AudioService _audioService = AudioService();
  final List<AudioTrack> _tracks = [];
  bool _isPlaying = false;
  int _currentBPM = 120;

  List<AudioTrack> get tracks => _tracks;
  bool get isPlaying => _isPlaying;
  int get currentBPM => _currentBPM;

  void addTrack(AudioTrack track) {
    _tracks.add(track);
    notifyListeners();
  }

  void removeTrack(String trackId) {
    _tracks.removeWhere((track) => track.id == trackId);
    notifyListeners();
  }

  void updateTrack(AudioTrack updatedTrack) {
    final index = _tracks.indexWhere((track) => track.id == updatedTrack.id);
    if (index != -1) {
      _tracks[index] = updatedTrack;
      notifyListeners();
    }
  }

  Future<void> playSequence() async {
    _isPlaying = true;
    notifyListeners();
    // TODO: Implement multi-track playback logic
  }

  Future<void> stopSequence() async {
    _isPlaying = false;
    await _audioService.stopPlayback();
    notifyListeners();
  }

  void setBPM(int bpm) {
    _currentBPM = bpm;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }
}
