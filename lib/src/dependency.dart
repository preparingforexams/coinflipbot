import 'package:application/dependency.dart' as application;
import 'package:get_it/get_it.dart';
import 'package:infrastructure/dependency.dart' as infrastructure;
import 'package:interface/dependency.dart' as interface_;

final _getIt = _configureDependencies();

T getInstance<T extends Object>() => _getIt<T>();

GetIt _configureDependencies() {
  final getIt = GetIt.asNewInstance();

  application.configureDependencies(getIt);
  infrastructure.configureDependencies(getIt);
  interface_.configureDependencies(getIt);

  return getIt;
}
