
import 'package:app_catalogo/core/app_component.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt locator = GetIt.instance;
@InjectableInit(
  preferRelativeImports: false,
  initializerName: r'$storeInitGetIt',
)
void _configureLocator() => $storeInitGetIt(locator);

Future<void> init() async {
  _configureLocator();

}
