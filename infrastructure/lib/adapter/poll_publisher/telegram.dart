import 'package:application/port.dart';
import 'package:domain/config.dart';
import 'package:telebot/telebot.dart' as telegram;

class TelegramPollPublisher implements PollPublisher {
  @override
  Future<String> publish(Poll poll) async {
    final bot = telegram.TelegramBot(Config.telegram.apiKey);
    final chatId = Config.telegram.chatId;
    final message = await bot.sendPoll(
      chatId,
      poll.title,
      poll.choices,
      isMultipleChoice: poll.options.isMultipleChoice,
      isAnonymous: poll.options.isAnonymous,
    );
    return message.poll!.id;
  }
}
