import 'package:flutter/material.dart';
import 'package:tourney_craft/app/modules/initial/cubit/initial_cubit.dart';

import '../../shared/components/base_app_bar.dart';
import '../../shared/themes/themes.dart';
import 'pages/create_tourney.dart';
import 'pages/play_tourney.dart';
import 'pages/ready_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late InitialCubit _cubit;
  @override
  void initState() {
    _cubit = InitialCubit();
    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BaseAppBar(showCenterIcons: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: sizeOf.height * .06),
            Hero(
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
                      width: sizeOf.width * .5,
                      child: Image.asset(
                        'assets/icon/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: sizeOf.height * .1),
            Hero(
              tag: 'playTourney',
              child: SizedBox(
                width: sizeOf.width * .55,
                height: sizeOf.height * .08,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PlayTourneyPage(),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Cadastrar no Torneio'.toUpperCase(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Hero(
              tag: 'createTourney',
              child: SizedBox(
                width: sizeOf.width * .55,
                height: sizeOf.height * .08,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreateTourneyPage(
                        cubit: _cubit,
                      ),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text('Criar Torneio'.toUpperCase()),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ReadyPage(),
                ));
              },
              child: Text(
                'Já estou em um torneio',
                style: AppTextStyle.subtitleStyle.copyWith(
                  fontSize: 14,
                  color: AppColors.darkPrimary,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
