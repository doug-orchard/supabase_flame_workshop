class RoundState {
  RoundState({
    required this.seed,
    required this.startedAt,
    required this.participants,
  }) : alive = participants.toSet();

  final int seed;
  final int startedAt;
  final List<String> participants;
  final Set<String> alive;
  String? winnerId;
}
