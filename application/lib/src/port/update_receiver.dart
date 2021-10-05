typedef UpdateCallback = Future<void> Function(Map);

abstract class UpdateReceiver {
  Future<void> listen(UpdateCallback handler);
}
