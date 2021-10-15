import 'dart:math';

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
      if (message.text.startsWith('/flip')) {
        final random = Random();
        final result = random.nextBool() ? "Heads" : "Tails";
        _messageSender.sendMessage(
          chatId: message.chat.id,
          text: "The results are in and it's $result",
          replyToMessageId: message.id,
        );
      }
    } else {
      log.warning('Dropping unknown message type: ${message.runtimeType}');
    }
  }
}
