import 'package:meta/meta.dart';

@immutable
class PollOptions {
  final bool isAnonymous;

  final bool isMultipleChoice;

  const PollOptions({
    this.isAnonymous = false,
    this.isMultipleChoice = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PollOptions &&
          runtimeType == other.runtimeType &&
          isAnonymous == other.isAnonymous &&
          isMultipleChoice == other.isMultipleChoice;

  @override
  int get hashCode => isAnonymous.hashCode ^ isMultipleChoice.hashCode;

  @override
  String toString() {
    return 'PollOptions{isAnonymous: $isAnonymous,'
        ' isMultipleChoice: $isMultipleChoice}';
  }
}

@immutable
class Poll {
  final String title;
  final List<String> choices;
  final PollOptions options;

  Poll({
    required this.title,
    required this.choices,
    this.options = const PollOptions(),
  });
}

abstract class PollPublisher {
  Future<String> publish(Poll poll);
}
