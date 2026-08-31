class LobbyPresence {
  const LobbyPresence({
    required this.id,
    required this.name,
    required this.colorIndex,
    required this.phase,
    this.seed,
    this.startedAt,
  });

  factory LobbyPresence.fromJson(Map<String, dynamic> json) {
    return LobbyPresence(
      id: json['id'] as String,
      name: json['name'] as String,
      colorIndex: json['color'] as int,
      phase: json['phase'] as String,
      seed: json['seed'] as int?,
      startedAt: json['startedAt'] as int?,
    );
  }

  final String id;
  final String name;
  final int colorIndex;
  final String phase;
  final int? seed;
  final int? startedAt;

  bool get inMatch => seed != null && startedAt != null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': colorIndex,
      'phase': phase,
      'seed': seed,
      'startedAt': startedAt,
    };
  }
}
