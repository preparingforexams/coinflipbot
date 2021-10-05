import 'dart:math';

import 'package:application/port.dart';
import 'package:domain/config.dart';
import 'package:telebot/telebot.dart' as telegram;

class LongPollTelegramUpdateReceiver implements UpdateReceiver {
  int? _lastUpdateId;

  @override
  Future<void> listen(UpdateCallback handler) async {
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
        // TODO: add update to domain model
        await handler({"text": update.message?.text});
      }
    }
  }
}
