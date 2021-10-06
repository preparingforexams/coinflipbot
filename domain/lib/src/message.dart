import 'chat.dart';
import 'poll.dart';

abstract class Message {
  final int id;
  final DateTime date;
  final Chat chat;

  Message._({
    required this.id,
    required this.date,
    required this.chat,
  });
}

class TextMessage extends Message {
  final String text;

  TextMessage({
    required int id,
    required DateTime date,
    required Chat chat,
    required this.text,
  }) : super._(id: id, date: date, chat: chat);
}

class PollMessage extends Message {
  final Poll poll;

  PollMessage({
    required int id,
    required DateTime date,
    required Chat chat,
    required this.poll,
  }) : super._(id: id, date: date, chat: chat);
}
