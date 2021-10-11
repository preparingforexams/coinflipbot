import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'dependency.config.dart';

@InjectableInit(
  preferRelativeImports: false,
  ignoreUnregisteredTypesInPackages: [
    'application/use_case',
    'application/port',
  ],
)
void configureDependencies(GetIt getIt) => $initGetIt(getIt);
