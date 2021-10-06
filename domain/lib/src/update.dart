import 'message.dart';

abstract class Update {
  final int id;

  Update._(this.id);
}

class MessageUpdate extends Update {
  final Message message;

  MessageUpdate(int id, this.message) : super._(id);
}
