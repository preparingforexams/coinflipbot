import 'package:application/port.dart' as port;
import 'package:domain/config.dart';
import 'package:domain/model.dart' as model;
import 'package:domain/outbound_model.dart' as outbound_model;
import 'package:infrastructure/translation/deserialize.dart' as deserialize;
import 'package:injectable/injectable.dart';
import 'package:telebot/telebot.dart' as telegram;

@Injectable(
  as: port.PollPublisher,
)
class TelegramPollPublisher implements port.PollPublisher {
  @override
  Future<model.Message> publish(outbound_model.Poll poll) async {
    final bot = telegram.TelegramBot(Config.telegram.apiKey);
    final chatId = Config.telegram.chatId;
    if (poll is outbound_model.RegularPoll) {
      final message = await bot.sendPoll(
        chatId,
        poll.title,
        poll.choices,
        isMultipleChoice: poll.isMultipleChoice,
        isAnonymous: poll.isAnonymous,
      );

      return deserialize.message(message);
    } else {
      throw ArgumentError.value(poll, 'poll', 'Unsupported poll type');
    }
  }
}
