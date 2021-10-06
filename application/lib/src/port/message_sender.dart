abstract class MessageSender {
  Future<void> sendMessage({
    required String chatId,
    required String text,
    String? replyToMessageId,
  });
}
