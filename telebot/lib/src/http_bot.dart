import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:telebot/src/model/update.dart';

import 'bot.dart';
import 'exception.dart';
import 'model/message.dart' as message_model;
import 'model/poll.dart' as poll_model;
import 'model/update.dart' as update_model;

const baseUrl = "https://api.telegram.org/bot";

class HttpTelegramBot implements TelegramBot {
  final http.Client _client;
  final Uri botUrl;

  HttpTelegramBot(
    String apiKey,
  )   : _client = http.Client(),
        botUrl = Uri.parse("$baseUrl$apiKey/");

  Uri _method(String methodName) {
    return botUrl.resolve(methodName);
  }

  Future _post(
    String methodName,
    Object body, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    final uri = _method(methodName);
    final encodedBody = jsonEncode(body);

    final request = http.Request("POST", uri)
      ..headers['Content-Type'] = 'application/json'
      ..body = encodedBody;

    final response = await _client.send(request);
    if (response.statusCode >= 500) {
      throw ServerUnavailableException("Server error: ${response.statusCode}");
    }

    final encodedResponseBody = await response.stream.bytesToString();
    final responseBody = jsonDecode(encodedResponseBody);

    if (response.statusCode >= 400 || !responseBody['ok']) {
      throw BadRequestException(responseBody['description']);
    }

    return responseBody['result'];
  }

  @override
  Future<List<Update>> getUpdates({
    required int? lastUpdateId,
    int limit = 100,
    List<String>? allowedUpdates,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    final body = <String, dynamic>{
      'timeout': timeout.inSeconds,
      'limit': limit,
    };

    if (lastUpdateId != null) {
      body['offset'] = lastUpdateId + 1;
    }

    if (allowedUpdates != null) {
      body['allowed_updates'] = allowedUpdates;
    }

    final response = await _post(
      'getUpdates',
      body,
      timeout: timeout + Duration(seconds: 5),
    );

    return [for (final update in response) update_model.fromJson(update)];
  }

  @override
  Future<message_model.Message> sendMessage(
    String chatId,
    String message,
  ) async {
    final response = await _post(
      'sendMessage',
      {
        'chat_id': chatId,
        'text': message,
      },
    );

    return message_model.fromJson(response);
  }

  @override
  Future<message_model.Message> sendPoll(
    String chatId,
    String question,
    List<String> options, {
    bool isAnonymous = false,
    bool isMultipleChoice = false,
    poll_model.QuizOptions? quizOptions,
    bool disableNotifications = false,
  }) async {
    final type = quizOptions == null
        ? poll_model.PollType.regular
        : poll_model.PollType.quiz;
    if (type == poll_model.PollType.quiz && isMultipleChoice) {
      throw ArgumentError('Cannot use multiple choice and quiz together');
    }

    if (options.length < 2 || options.length > 10) {
      throw ArgumentError.value(options, 'options', 'Must be between 2 and 10');
    }

    final body = {
      'chat_id': chatId,
      'question': question,
      'options': options,
      'is_anonymous': isAnonymous,
      'allows_multiple_answers': isMultipleChoice,
      'type': type.toJsonValue(),
      'disable_notifications': disableNotifications,
    };

    if (quizOptions != null) {
      body['correct_option_id'] = quizOptions.correctOptionIndex;

      final explanation = quizOptions.explanation;
      if (explanation != null) body['explanation'] = explanation;
    }

    final response = await _post('sendPoll', body);
    return message_model.fromJson(response);
  }
}
