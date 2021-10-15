import 'package:application/port.dart' as port;
import 'package:domain/config.dart';
import 'package:injectable/injectable.dart';
import 'package:telebot/telebot.dart';

@Injectable(
  as: port.MessageSender,
)
class TelegramMessageSender implements port.MessageSender {
  @override
  Future<void> sendMessage({
    required int chatId,
    required String text,
    int? replyToMessageId,
  }) async {
    final bot = TelegramBot(Config.telegram.apiKey);
    await bot.sendMessage(
      chatId,
      text,
      replyToMessageId!,
    );
  }
}
