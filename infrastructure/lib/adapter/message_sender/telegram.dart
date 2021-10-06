import 'package:application/port.dart' as port;
import 'package:domain/config.dart';
import 'package:telebot/telebot.dart';

class TelegramMessageSender implements port.MessageSender {
  @override
  Future<void> sendMessage({
    required String chatId,
    required String text,
    String? replyToMessageId,
  }) async {
    final bot = TelegramBot(Config.telegram.apiKey);
    // TODO replyToMessageId is ignored
    await bot.sendMessage(
      chatId,
      text,
    );
  }
}
