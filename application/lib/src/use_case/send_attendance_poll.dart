import 'package:application/src/port/poll_publisher.dart';

class SendAttendancePoll {
  final PollPublisher _pollPublisher;

  SendAttendancePoll(this._pollPublisher);

  Future<void> call() async {
    // TODO send correct poll
    // TODO save poll ID somewhere
    await _pollPublisher.publish(
      Poll(
        title: 'TODO',
        choices: ['TODO', 'TODO2'],
      ),
    );
  }
}
