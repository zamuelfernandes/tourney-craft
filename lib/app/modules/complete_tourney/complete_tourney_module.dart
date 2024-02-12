import 'package:flutter_modular/flutter_modular.dart';

import 'complete_tourney_page.dart';

class CompleteTourneyModule extends Module {
  @override
  void routes(RouteManager r) {
    r
      ..child(
        Modular.initialRoute,
        child: (context) => CompleteTourneyPage(
          tourneyId: r.args.data,
        ),
      );

    super.routes(r);
  }
}
