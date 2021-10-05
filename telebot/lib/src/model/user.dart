class User {
  final int id;
  final bool isBot;
  final String firstName;
  final String? lastName;
  final String? username;

  String get effectiveUsername => username ?? firstName;

  User({
    required this.id,
    required this.isBot,
    required this.firstName,
    this.lastName,
    this.username,
  });
}

User fromJson(Map json) {
  return User(
    id: json['id'],
    isBot: json['is_bot'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    username: json['username'],
  );
}
