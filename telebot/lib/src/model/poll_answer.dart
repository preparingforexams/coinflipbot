import 'user.dart' as user_model;

class PollAnswer {
  final String pollId;
  final user_model.User user;
  final List<int> optionIds;

  PollAnswer({
    required this.pollId,
    required this.user,
    required this.optionIds,
  });
}

PollAnswer fromJson(Map json) {
  return PollAnswer(
    pollId: json['poll_id'],
    user: user_model.fromJson(json['user']),
    optionIds: [for (final id in json['option_ids']) id],
  );
}
