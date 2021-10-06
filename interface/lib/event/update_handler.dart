import 'package:application/port.dart' as port;
import 'package:application/use_case.dart' as use_case;
import 'package:domain/model.dart' as model;
import 'package:logging/logging.dart';

class UpdateHandler {
  final Logger log = Logger('UpdateHandler');
  final port.UpdateReceiver _receiver;

  final use_case.EchoMessage echoMessage;

  UpdateHandler(
    this._receiver, {
    required this.echoMessage,
  });

  Future<void> call() async {
    await _receiver.listen(_onUpdate);
  }

  Future<void> _onUpdate(model.Update update) async {
    if (update is model.MessageUpdate) {
      await echoMessage(update.message);
    }
  }
}
