import 'package:flutter/material.dart';

import '../../shared/components/base_app_bar.dart';
import 'pages/create_tourney.dart';
import 'pages/play_tourney.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.of(context).size;

    return Scaffold(
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
                      'Entrar no Torneio'.toUpperCase(),
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
                      builder: (context) => const CreateTourneyPage(),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text('Criar Torneio'.toUpperCase()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
