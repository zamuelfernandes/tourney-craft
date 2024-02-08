import 'package:flutter_modular/flutter_modular.dart';

import 'modules/initial/initial_module.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module(
      '/',
      module: InitialModule(),
    );
    super.routes(r);
  }
}
