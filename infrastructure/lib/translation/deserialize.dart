import 'package:domain/model.dart' as model;
import 'package:telebot/telebot.dart' as telegram;

class DeserializationException {
  final String message;

  DeserializationException(this.message);

  @override
  String toString() => message;
}

model.Update update(telegram.Update update) {
  final telegramMessage = update.message;
  if (telegramMessage != null) {
    return model.MessageUpdate(
      update.id,
      message(telegramMessage),
    );
  } else {
    throw DeserializationException('Unknown update type');
  }
}

model.Message message(telegram.Message message) {
  final text = message.text;
  if (text != null) {
    return model.TextMessage(
      id: message.id,
      date: message.date,
      chat: chat(message.chat),
      text: text,
    );
  } else {
    throw DeserializationException('Unknown message type');
  }
}

model.Chat chat(telegram.Chat chat) {
  return model.Chat(
    id: chat.id,
  );
}
