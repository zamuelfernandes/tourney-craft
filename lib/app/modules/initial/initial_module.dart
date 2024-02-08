import 'package:flutter_modular/flutter_modular.dart';

import 'initial_page.dart';

class InitialModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (context) => const InitialPage(),
    );

    super.routes(r);
  }
}
