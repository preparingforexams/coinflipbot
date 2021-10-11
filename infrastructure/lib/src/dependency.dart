import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'dependency.config.dart';

@InjectableInit(
  preferRelativeImports: false,
  ignoreUnregisteredTypesInPackages: ['application/port'],
)
void configureDependencies(GetIt getIt) => $initGetIt(getIt);
