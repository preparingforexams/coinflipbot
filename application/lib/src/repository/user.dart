import 'package:domain/model.dart' as model;

abstract class UserRepository {
  Future<model.User> findById(String id);
}
