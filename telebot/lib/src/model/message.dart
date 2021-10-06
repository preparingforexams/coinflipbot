import '../util.dart';
import 'chat.dart' as chat_model;
import 'poll.dart' as poll_model;
import 'user.dart' as user_model;

class Message {
  final int id;
  final DateTime date;
  final chat_model.Chat chat;
  final user_model.User? from;
  final chat_model.Chat? senderChat;
  final poll_model.Poll? poll;
  final String? text;

  Message._({
    required this.id,
    required this.date,
    required this.chat,
    required this.from,
    required this.senderChat,
    required this.poll,
    required this.text,
  });
}

Message fromJson(Map json) {
  return Message._(
    id: json['message_id'],
    date: DateTime.fromMillisecondsSinceEpoch(json['date'], isUtc: true),
    chat: chat_model.fromJson(json['chat']),
    from: optional(json['from'] as Map?, user_model.fromJson),
    senderChat: optional(json['sender_chat'] as Map?, chat_model.fromJson),
    poll: optional(json['poll'] as Map?, poll_model.fromJson),
    text: json['text'],
  );
}
