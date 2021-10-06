import 'package:application/port.dart' as port;
import 'package:logging/logging.dart';

class UpdateHandler {
  final Logger log = Logger('UpdateHandler');
  final port.UpdateReceiver _receiver;

  UpdateHandler(this._receiver);

  Future<void> call() async {
    await _receiver.listen(_onUpdate);
  }

  Future<void> _onUpdate(Map update) async {
    log.info("Received update $update");
  }
}
