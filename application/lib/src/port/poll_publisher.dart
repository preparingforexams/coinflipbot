import 'package:domain/model.dart' as model;
import 'package:domain/outbound_model.dart' as outbound_model;

abstract class PollPublisher {
  Future<model.Message> publish(outbound_model.Poll poll);
}
