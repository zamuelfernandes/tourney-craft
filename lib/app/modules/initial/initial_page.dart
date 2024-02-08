import 'package:flutter/material.dart';

import '../../shared/components/base_app_bar.dart';

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
            Card(
              elevation: 15,
              surfaceTintColor: Colors.white,
              color: Colors.white,
              shape: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/icon/logo.png',
                    width: sizeOf.width * .5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: sizeOf.height * .1),
            SizedBox(
              width: sizeOf.width * .55,
              height: sizeOf.height * .08,
              child: ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Entrar no Torneio'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: sizeOf.width * .55,
              height: sizeOf.height * .08,
              child: ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Criar Torneio'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
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
