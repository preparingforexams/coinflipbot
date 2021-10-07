import 'dart:io';

class Schedule {
  Schedule._();

  final int attendanceHour = _resolve("SCHEDULE_ATTENDANCE_HOUR", 16);
}

class TelegramConfig {
  TelegramConfig._();

  final String apiKey = _resolve('TELEGRAM_API_KEY');
  final int chatId = _resolve('TELEGRAM_CHAT_ID');
}

class Config {
  Config._();

  static final String chatId = _resolve('CHAT_ID');

  static final Schedule schedule = Schedule._();
  static final TelegramConfig telegram = TelegramConfig._();
}

T _resolve<T>(String key, [T? defaultValue]) {
  final value = Platform.environment[key];
  if (value == null || value.isEmpty) {
    if (defaultValue != null) {
      return defaultValue;
    } else {
      throw StateError('Missing environment variable: $key');
    }
  }
  if (T == String) {
    return value as T;
  } else if (T == int) {
    return int.parse(value) as T;
  } else {
    throw ArgumentError.value(
      T.runtimeType.toString(),
      'T',
      'Invalid config value type',
    );
  }
}
