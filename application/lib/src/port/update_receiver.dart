import 'package:domain/model.dart' as model;

typedef UpdateCallback = Future<void> Function(model.Update);

abstract class UpdateReceiver {
  Future<void> listen(UpdateCallback handler);
}
