import 'http_bot.dart';
import 'model/message.dart';
import 'model/poll.dart';
import 'model/update.dart';

abstract class TelegramBot {
  factory TelegramBot(String apiKey) {
    if (apiKey.isEmpty) {
      throw ArgumentError.value(apiKey, "apiKey", "Must not be empty");
    }
    return HttpTelegramBot(apiKey);
  }

  Future<List<Update>> getUpdates({
    required int? lastUpdateId,
    int limit = 100,
    List<String>? allowedUpdates,
    Duration timeout = const Duration(seconds: 10),
  });

  Future<Message> sendMessage(int chatId, String message);

  Future<Message> sendPoll(
    int chatId,
    String question,
    List<String> options, {
    bool isAnonymous = false,
    bool isMultipleChoice = false,
    QuizOptions? quizOptions,
    bool disableNotifications = false,
  });
}
