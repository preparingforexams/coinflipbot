import 'package:meta/meta.dart';

@immutable
abstract class Poll {
  final String title;
  final List<String> choices;
  final bool isAnonymous;

  const Poll._({
    required this.title,
    required this.choices,
    required this.isAnonymous,
  });
}

@immutable
class RegularPoll extends Poll {
  final bool isMultipleChoice;

  RegularPoll({
    required String title,
    required List<String> choices,
    bool isAnonymous = false,
    this.isMultipleChoice = false,
  }) : super._(
          title: title,
          choices: choices,
          isAnonymous: isAnonymous,
        );
}
