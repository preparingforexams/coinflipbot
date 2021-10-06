abstract class MessageSender {
  Future<void> sendMessage({
    required int chatId,
    required String text,
    int? replyToMessageId,
  });
}
