class PollOption {
  final String text;
  final int voterCount;

  PollOption({
    required this.text,
    required this.voterCount,
  });
}

enum PollType {
  regular,
  quiz,
}

extension PollTypeToJson on PollType {
  String toJsonValue() {
    switch (this) {
      case PollType.regular:
        return 'regular';
      case PollType.quiz:
        return 'quiz';
    }
  }
}

class QuizOptions {
  final String? explanation;
  final int correctOptionIndex;

  QuizOptions({
    required this.correctOptionIndex,
    this.explanation,
  });
}

class Poll {
  final String id;
  final String question;
  final List<PollOption> options;
  final int totalVoterCount;
  final bool isClosed;
  final bool isAnonymous;
  final bool isMultipleChoice;
  final PollType type;
  final int? correctOptionId;
  final String? explanation;

  Poll({
    required this.id,
    required this.question,
    required this.options,
    required this.totalVoterCount,
    required this.isClosed,
    required this.isAnonymous,
    required this.isMultipleChoice,
    required this.type,
    required this.correctOptionId,
    required this.explanation,
  });
}

PollType _pollType(String identifier) {
  switch (identifier) {
    case 'quiz':
      return PollType.quiz;
    case 'regular':
      return PollType.regular;
    default:
      throw ArgumentError.value(identifier, 'identifier', 'Invalid poll type');
  }
}

PollOption _pollOption(Map json) {
  return PollOption(
    text: json['text'],
    voterCount: json['voter_count'],
  );
}

Poll fromJson(Map json) {
  return Poll(
    id: json['id'],
    question: json['question'],
    options: [for (final option in json['options']) _pollOption(option)],
    totalVoterCount: json['total_voter_count'],
    isClosed: json['is_closed'],
    isAnonymous: json['is_anonymous'],
    isMultipleChoice: json['allows_multiple_answers'],
    type: _pollType(json['type']),
    correctOptionId: json['correct_option_id'],
    explanation: json['explanation'],
  );
}
