import 'package:flutter_modular/flutter_modular.dart';

import 'cubit/play_tourney_cubit.dart';
import 'play_tourney_page.dart';

class PlayTourneyModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton(PlayTourneyCubit.new);
    i.add(PlayTourneyCubit().fetchData);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r
      ..child(
        Modular.initialRoute,
        child: (context) => PlayTourneyPage(),
      );

    super.routes(r);
  }
}
