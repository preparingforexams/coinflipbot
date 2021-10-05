import 'package:application/port.dart' as port;
import 'package:application/repository.dart' as repository;
import 'package:application/use_case.dart' as use_case;
import 'package:get_it/get_it.dart';
import 'package:infrastructure/adapter/poll_publisher/telegram.dart';
import 'package:infrastructure/adapter/update_receiver/long_poll_telegram.dart';
import 'package:infrastructure/respository/user/postgres.dart';
import 'package:interface/event/update_handler.dart';

final _getIt = _configureDependencies();

T getInstance<T extends Object>() => _getIt<T>();

GetIt _configureDependencies() {
  final getIt = GetIt.asNewInstance();

  // repositories
  getIt.registerFactory<repository.UserRepository>(
    () => PostgresUserRepository(),
  );

  // ports
  getIt.registerFactory<port.PollPublisher>(
    () => TelegramPollPublisher(),
  );
  getIt.registerLazySingleton<port.UpdateReceiver>(
    () => LongPollTelegramUpdateReceiver(),
  );

  // use cases
  getIt.registerFactory(
    () => use_case.SendAttendancePoll(
      getIt<port.PollPublisher>(),
    ),
  );

  // interfaces
  getIt.registerFactory(
    () => UpdateHandler(
      getIt<port.UpdateReceiver>(),
    ),
  );

  return getIt;
}
