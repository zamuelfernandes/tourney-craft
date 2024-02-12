import 'package:flutter_modular/flutter_modular.dart';
import 'package:tourney_craft/app/modules/complete_tourney/complete_tourney_page.dart';
import 'package:tourney_craft/app/shared/constants/routes.dart';

import 'initial_page.dart';

class InitialModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r
      ..child(
        Modular.initialRoute,
        child: (context) => const InitialPage(),
      )
      ..child(
        Routes.completeTourney,
        child: (context) => CompleteTourneyPage(
          tourneyId: r.args.data,
        ),
        transition: TransitionType.fadeIn,
      );

    super.routes(r);
  }
}
