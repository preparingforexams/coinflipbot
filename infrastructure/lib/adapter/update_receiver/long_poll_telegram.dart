import 'dart:math';

import 'package:application/port.dart' as port;
import 'package:domain/config.dart';
import 'package:domain/model.dart' as model;
import 'package:logging/logging.dart';
import 'package:telebot/telebot.dart' as telegram;

class LongPollTelegramUpdateReceiver implements port.UpdateReceiver {
  final Logger _log = Logger('LongPollTelegramUpdateReceiver');
  int? _lastUpdateId;

  @override
  Future<void> listen(port.UpdateCallback handler) async {
    final bot = telegram.TelegramBot(Config.telegram.apiKey);
    while (true) {
      final updates = await bot.getUpdates(
        lastUpdateId: _lastUpdateId,
      );
      for (final update in updates) {
        if (_lastUpdateId == null) {
          _lastUpdateId = update.id;
        } else {
          _lastUpdateId = max(update.id, _lastUpdateId!);
        }

        final modelUpdate = _buildDomainUpdate(update);
        if (modelUpdate == null) {
          _log.warning("Dropping update because I can't read");
        } else {
          await handler(modelUpdate);
        }
      }
    }
  }

  model.Update? _buildDomainUpdate(telegram.Update update) {
    final message = update.message;
    if (message == null) {
      return null;
    }

    final domainMessage = _buildDomainMessage(message);
    if (domainMessage == null) {
      return null;
    }

    return model.MessageUpdate(update.id, domainMessage);
  }

  model.Message? _buildDomainMessage(telegram.Message message) {
    final text = message.text;
    if (text != null) {
      return model.TextMessage(
        id: message.id,
        date: message.date,
        chat: _buildDomainChat(message.chat),
        text: text,
      );
    }
  }

  model.Chat _buildDomainChat(telegram.Chat chat) {
    return model.Chat(
      id: chat.id,
    );
  }
}
