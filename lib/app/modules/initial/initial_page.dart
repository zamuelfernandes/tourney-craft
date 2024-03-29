import 'package:flutter/material.dart';
import 'package:tourney_craft/app/modules/initial/cubit/initial_cubit.dart';
import 'package:tourney_craft/app/shared/components/base_elevated_button.dart';

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
      body: SingleChildScrollView(
        child: Center(
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
                tag: 'createTourney',
                child: BaseElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreateTourneyPage(
                        cubit: _cubit,
                      ),
                    ));
                  },
                  label: 'Criar Torneio',
                ),
              ),
              const SizedBox(height: 30),
              Hero(
                tag: 'playTourney',
                child: BaseElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PlayTourneyPage(
                        cubit: _cubit,
                      ),
                    ));
                  },
                  label: 'Cadastrar no Torneio',
                ),
              ),
              const SizedBox(height: 80),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReadyPage(
                      cubit: _cubit,
                    ),
                  ));
                },
                child: Text(
                  'Já estou em um torneio'.toUpperCase(),
                  style: AppTextStyle.subtitleStyle.copyWith(
                    fontSize: 14,
                    color: AppColors.checkColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.checkColor,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Text('Tourney Craft © 2024'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
