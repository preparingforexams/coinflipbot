import 'dart:io';

class TelegramConfig {
  TelegramConfig._();

  final String apiKey = _resolve('TELEGRAM_API_KEY');
  final String chatId = _resolve('TELEGRAM_CHAT_ID');
}

class Config {
  Config._();

  static final String chatId = _resolve('CHAT_ID');

  static final TelegramConfig telegram = TelegramConfig._();
}

T _resolve<T>(String key) {
  final value = Platform.environment[key];
  if (value == null) {
    throw StateError('Missing environment variable: $key');
  }
  if (T == String) {
    return value as T;
  } else {
    throw ArgumentError.value(
      T.runtimeType.toString(),
      'T',
      'Invalid config value type',
    );
  }
}
