import 'package:application/port.dart' as port;
import 'package:domain/outbound_model.dart' as outbound_model;
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@injectable
class SendAttendancePoll {
  final Logger _log = Logger('SendAttendancePoll');
  final port.PollPublisher _pollPublisher;

  SendAttendancePoll(this._pollPublisher);

  Future<void> call() async {
    _log.info('Sending attendance poll');

    // TODO send correct poll
    // TODO save poll ID somewhere
    final message = await _pollPublisher.publish(
      outbound_model.RegularPoll(
        title: 'Are you annoyed yet?',
        choices: ['Yes', 'No'],
      ),
    );
  }
}
