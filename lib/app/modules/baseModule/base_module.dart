import 'package:flutter_modular/flutter_modular.dart';

import 'cubit/base_cubit.dart';
import 'base_page.dart';

class BaseModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton(BaseCubit.new);
    i.add(BaseCubit().fetchData);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r
      ..child(
        Modular.initialRoute,
        child: (context) => BasePage(),
      );

    super.routes(r);
  }
}
