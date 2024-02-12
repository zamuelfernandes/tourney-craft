import 'package:flutter_modular/flutter_modular.dart';

import 'cubit/sample_cubit.dart';
import 'sample_page.dart';

class SampleModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton(SampleCubit.new);
    i.add(SampleCubit().fetchData);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r
      ..child(
        Modular.initialRoute,
        child: (context) => SamplePage(),
      );

    super.routes(r);
  }
}
