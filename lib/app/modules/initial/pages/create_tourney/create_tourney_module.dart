import 'package:flutter_modular/flutter_modular.dart';

import 'cubit/create_tourney_cubit.dart';
import 'create_tourney_page.dart';

class CreateTourneyModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton(CreateTourneyCubit.new);
    i.add(CreateTourneyCubit().fetchData);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r
      ..child(
        Modular.initialRoute,
        child: (context) => CreateTourneyPage(),
      );

    super.routes(r);
  }
}
