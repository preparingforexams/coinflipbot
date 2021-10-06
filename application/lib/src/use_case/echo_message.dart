import 'package:application/port.dart' as port;

class EchoMessage {
  final port.MessageSender _messageSender;

  EchoMessage(this._messageSender);

  Future<void> call() async{

  }
}