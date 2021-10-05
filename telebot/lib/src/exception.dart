class TelegramException implements Exception {}

class BadRequestException extends TelegramException {
  final String description;

  BadRequestException(this.description);

  @override
  String toString() {
    return 'BadRequestException{description: $description}';
  }
}

class ServerUnavailableException extends TelegramException {
  final String message;

  ServerUnavailableException(this.message);

  @override
  String toString() {
    return 'ServerUnavailableException{message: $message}';
  }
}