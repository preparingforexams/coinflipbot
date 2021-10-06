import 'dart:math';

import 'package:application/port.dart' as port;
import 'package:domain/config.dart';
import 'package:domain/model.dart' as model;
import 'package:infrastructure/translation/deserialize.dart' as deserialize;
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

        final model.Update modelUpdate;
        try {
          modelUpdate = deserialize.update(update);
        } on deserialize.DeserializationException catch (e, s) {
          _log.warning('Could not deserialize update', e, s);
          continue;
        }

        await handler(modelUpdate);
      }
    }
  }
}
