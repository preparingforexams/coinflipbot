enum ChatType {
  private,
  group,
  supergroup,
  channel,
}

class Chat {
  final int id;
  final ChatType type;
  final String? title;

  Chat({
    required this.id,
    required this.type,
    this.title,
  });
}

ChatType _chatType(String identifier) {
  switch (identifier) {
    case 'private':
      return ChatType.private;
    case 'group':
      return ChatType.group;
    case 'supergroup':
      return ChatType.supergroup;
    case 'channel':
      return ChatType.channel;
    default:
      throw ArgumentError.value(identifier, 'identifier', 'Invalid chat type');
  }
}

Chat fromJson(Map json) {
  return Chat(
    id: json['id'],
    type: _chatType(json['type']),
    title: json['title'],
  );
}
