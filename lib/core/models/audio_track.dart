class AudioTrack {
  final String id;
  final String name;
  final String filePath;
  final Duration duration;
  bool isMuted;
  double volume;
  int order;

  AudioTrack({
    required this.id,
    required this.name,
    required this.filePath,
    required this.duration,
    this.isMuted = false,
    this.volume = 1.0,
    this.order = 0,
  });

  AudioTrack copyWith({
    String? id,
    String? name,
    String? filePath,
    Duration? duration,
    bool? isMuted,
    double? volume,
    int? order,
  }) {
    return AudioTrack(
      id: id ?? this.id,
      name: name ?? this.name,
      filePath: filePath ?? this.filePath,
      duration: duration ?? this.duration,
      isMuted: isMuted ?? this.isMuted,
      volume: volume ?? this.volume,
      order: order ?? this.order,
    );
  }
}
