import 'package:application/repository.dart' as repository;
import 'package:domain/model.dart' as model;
import 'package:injectable/injectable.dart';

@Injectable(
  as: repository.UserRepository,
)
class PostgresUserRepository implements repository.UserRepository {
  @override
  Future<model.User> findById(String id) async {
    // TODO: implement findById
    throw UnimplementedError();
  }
}
