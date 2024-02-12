import 'package:flutter_modular/flutter_modular.dart';

import 'cubit/complete_tourney_cubit.dart';
import 'complete_tourney_page.dart';

class CompleteTourneyModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton(CompleteTourneyCubit.new);
    i.add(CompleteTourneyCubit().fetchData);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r
      ..child(
        Modular.initialRoute,
        child: (context) => CompleteTourneyPage(),
      );

    super.routes(r);
  }
}
