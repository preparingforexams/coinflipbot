import 'package:telebot/src/util.dart';

import 'message.dart' as message_model;
import 'poll.dart' as poll_model;
import 'poll_answer.dart' as poll_answer_model;

class Update {
  final int id;
  final message_model.Message? message;
  final poll_model.Poll? poll;
  final poll_answer_model.PollAnswer? pollAnswer;

  Update._({
    required this.id,
    this.message,
    this.poll,
    this.pollAnswer,
  });
}

Update fromJson(Map<String, dynamic> json) {
  return Update._(
    id: json['update_id'],
    message: optional(json['message'] as Map?, message_model.fromJson),
    poll: optional(json['poll'] as Map?, poll_model.fromJson),
    pollAnswer: optional(
      json['poll_answer'] as Map?,
      poll_answer_model.fromJson,
    ),
  );
}
