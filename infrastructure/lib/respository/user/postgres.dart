import 'package:application/repository.dart';
import 'package:domain/model.dart';

class PostgresUserRepository implements UserRepository {
  @override
  Future<User> findById(String id) async {
    // TODO: implement findById
    throw UnimplementedError();
  }
}
