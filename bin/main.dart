import 'dart:io';

import 'package:application/use_case.dart' as use_case;
import 'package:args/args.dart';
import 'package:interface/event/update_handler.dart';
import 'package:logging/logging.dart';
import 'package:regular_dicers_bot/src/dependency.dart';

Future<void> main(List<String> arguments) {
  _initLogging();
  final log = Logger.root;
  final parser = ArgParser();
  parser.addCommand('handle_updates');
  parser.addCommand('send_attendance_poll');

  final parsed = parser.parse(arguments);

  if (parsed.rest.isNotEmpty) {
    log.severe('Unknown options: ${parsed.rest}');
    exit(1);
  }

  switch (parsed.command?.name) {
    case 'handle_updates':
      return _handleUpdates();
    case 'send_attendance_poll':
      return _sendAttendancePoll();
    default:
      log.severe('Not a valid command');
      exit(1);
  }
}

void _initLogging() {
  Logger.root
    ..level = Level.FINE
    ..onRecord.listen((record) {
      print('${record.level.name} ${record.loggerName}: ${record.message}');
    });
}

Future<void> _handleUpdates() async {
  final updateHandler = getInstance<UpdateHandler>();
  await updateHandler();
}

Future<void> _sendAttendancePoll() async {
  final sendAttendancePoll = getInstance<use_case.SendAttendancePoll>();
  await sendAttendancePoll();
}
