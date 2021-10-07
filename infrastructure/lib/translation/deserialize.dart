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
  if (message.text != null) {
    return model.TextMessage(
      id: message.id,
      date: message.date,
      chat: chat(message.chat),
      text: message.text!,
    );
  } else if (message.poll != null) {
    return model.PollMessage(
      id: message.id,
      date: message.date,
      chat: chat(message.chat),
      poll: poll(message.poll!),
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

model.Poll poll(telegram.Poll poll) {
  return model.Poll(
    id: poll.id,
    title: poll.question,
    choices: [for (final option in poll.options) pollChoice(option)],
    totalVotes: poll.totalVoterCount,
    isClosed: poll.isClosed,
    isAnonymous: poll.isAnonymous,
    isMultipleChoice: poll.isMultipleChoice,
  );
}

model.PollChoice pollChoice(telegram.PollOption option) {
  return model.PollChoice(
    text: option.text,
    votes: option.voterCount,
  );
}
