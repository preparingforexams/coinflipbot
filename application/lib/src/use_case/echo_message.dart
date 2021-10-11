import 'package:application/port.dart' as port;
import 'package:domain/model.dart' as model;
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@injectable
class EchoMessage {
  final Logger log = Logger('EchoMessage');
  final port.MessageSender _messageSender;

  EchoMessage(this._messageSender);

  Future<void> call(model.Message message) async {
    if (message is model.TextMessage) {
      _messageSender.sendMessage(
        chatId: message.chat.id,
        text: message.text,
        replyToMessageId: message.id,
      );
    } else {
      log.warning('Dropping unknown message type: ${message.runtimeType}');
    }
  }
}
