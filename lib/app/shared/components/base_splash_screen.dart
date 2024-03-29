import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tourney_craft/app/shared/constants/constants.dart';
import 'package:tourney_craft/app/shared/services/tourney_repository.dart';

import '../constants/routes.dart';

class BaseSplashScreen extends StatefulWidget {
  const BaseSplashScreen({super.key});

  @override
  State<BaseSplashScreen> createState() => _BaseSplashScreenState();
}

class _BaseSplashScreenState extends State<BaseSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true, period: Duration(seconds: 1));

    Future.delayed(Duration(milliseconds: 3500), () async {
      final tourneyCode =
          await TourneyRepository().getValue(Constants.tourneyCodeFolder);
      final password =
          await TourneyRepository().getValue(Constants.admPasswordFolder);
      final status =
          await TourneyRepository().getValue(Constants.tourneyStatusFolder);

      if (status == '1' && password != null) {
        Modular.to.pushReplacementNamed(
          Routes.completeTourney,
          arguments: tourneyCode,
        );
      } else if (tourneyCode != null) {
        print('=== GO TO DASHBOARD ===');
        // Modular.to.pushReplacementNamed(Routes.play);
        Modular.to.pushReplacementNamed(Routes.initial);
      } else {
        Modular.to.pushReplacementNamed(Routes.initial);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _controller.value * 0.5 + 0.6,
              child: Hero(
                tag: 'logo',
                child: Card(
                  elevation: 15,
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  shape: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: Image.asset(
                          'assets/icon/logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
