import 'package:application/port.dart' as port;
import 'package:domain/outbound_model.dart' as outbound_model;

class SendAttendancePoll {
  final port.PollPublisher _pollPublisher;

  SendAttendancePoll(this._pollPublisher);

  Future<void> call() async {
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
