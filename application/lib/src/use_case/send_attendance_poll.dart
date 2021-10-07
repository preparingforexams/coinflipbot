import 'package:application/port.dart' as port;
import 'package:domain/outbound_model.dart' as outbound_model;
import 'package:logging/logging.dart';
import 'package:timezone/standalone.dart' as tz;

class SendAttendancePoll {
  final Logger _log = Logger('SendAttendancePoll');
  final port.PollPublisher _pollPublisher;

  SendAttendancePoll(this._pollPublisher);

  Future<bool> _isHammerTime() async {
    await tz.initializeTimeZone();
    final berlin = tz.getLocation('Europe/Berlin');

    final now = tz.TZDateTime.now(berlin);
    final target = tz.TZDateTime(
      berlin,
      now.year,
      now.month,
      now.day,
      16,
    );
    final delta = Duration(minutes: 5);
    return now.difference(target).abs() < delta;
  }

  Future<void> call() async {
    if (!await _isHammerTime()) {
      _log.fine("Skipping attendance poll because it ain't hammer time.");
      return;
    }

    // TODO send correct poll
    // TODO save poll ID somewhere
    final message = await _pollPublisher.publish(
      outbound_model.RegularPoll(
        title: 'TODO',
        choices: ['TODO', 'TODO2'],
      ),
    );
  }
}
