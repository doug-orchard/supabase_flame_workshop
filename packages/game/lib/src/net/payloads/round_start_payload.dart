class RoundStartPayload {
  const RoundStartPayload({
    required this.seed,
    required this.startedAt,
    required this.participants,
  });

  factory RoundStartPayload.fromJson(Map<String, dynamic> json) {
    return RoundStartPayload(
      seed: json['seed'] as int,
      startedAt: json['startedAt'] as int,
      participants: (json['participants'] as List<dynamic>).cast<String>(),
    );
  }

  final int seed;
  final int startedAt;
  final List<String> participants;

  Map<String, dynamic> toJson() {
    return {'seed': seed, 'startedAt': startedAt, 'participants': participants};
  }
}
