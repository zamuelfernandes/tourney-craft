import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';

class BaseSplashScreen extends StatefulWidget {
  const BaseSplashScreen({super.key});

  @override
  State<BaseSplashScreen> createState() => _BaseSplashScreenState();
}

class _BaseSplashScreenState extends State<BaseSplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Future.delayed(Duration(seconds: 5), () {
    //   Modular.to.pushReplacementNamed(Routes.initial);
    // });
  }

  @override
  void dispose() {
    super.dispose();
    // SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.manual,
    //   overlays: SystemUiOverlay.values,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.darkPrimary,
        width: double.infinity,
        child: Center(
          child: Image.asset(
            'assets/gifs/crabwalk.gif',
            width: MediaQuery.sizeOf(context).width * 0.9,
          ),
        ),
      ),
    );
  }
}
