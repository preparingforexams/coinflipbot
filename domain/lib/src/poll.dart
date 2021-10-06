class PollChoice {
  final String text;
  final int votes;

  PollChoice({
    required this.text,
    required this.votes,
  });
}

class Poll {
  final String id;
  final String title;
  final List<PollChoice> choices;
  final int totalVotes;
  final bool isClosed;
  final bool isAnonymous;
  final bool isMultipleChoice;

  Poll({
    required this.id,
    required this.title,
    required this.choices,
    required this.totalVotes,
    required this.isClosed,
    required this.isAnonymous,
    required this.isMultipleChoice,
  });
}
