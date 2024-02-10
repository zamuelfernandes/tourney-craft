import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../shared/components/base_app_bar.dart';

class PlayTourneyPage extends StatefulWidget {
  const PlayTourneyPage({super.key});

  @override
  State<PlayTourneyPage> createState() => _PlayTourneyPageState();
}

class _PlayTourneyPageState extends State<PlayTourneyPage> {
  final formKey = GlobalKey<FormState>();
  final playerNameEC = TextEditingController();
  final teamEC = TextEditingController();
  final tourneyCodeEC = TextEditingController();

  @override
  void dispose() {
    playerNameEC.dispose();
    teamEC.dispose();
    tourneyCodeEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Fazer Cadastro',
        showCenterIcons: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: sizeOf.height,
          ),
          color: Colors.white,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: BoxConstraints(maxWidth: sizeOf.width * .8),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: sizeOf.height * .06,
                      ),
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
                                width: sizeOf.width * .35,
                                child: Image.asset(
                                  'assets/icon/logo.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: playerNameEC,
                      validator: Validatorless.required('Campo obrigatório'),
                      // Validatorless.multiple([
                      //   Validatorless.required('E-mail obrigatório'),
                      //   Validatorless.email('E-mail inválido'),
                      // ]),
                      decoration: InputDecoration(
                        label: Text('Nome do Jogador:'.toUpperCase()),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: teamEC,
                      validator: Validatorless.required('Campo obrigatório'),
                      decoration: InputDecoration(
                        label: Text('Nome do Time:'.toUpperCase()),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: tourneyCodeEC,
                      validator: Validatorless.required('Campo obrigatório'),
                      decoration: InputDecoration(
                        label: Text('Código do Torneio:'.toUpperCase()),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 40),
                    Hero(
                      tag: 'playTourney',
                      child: SizedBox(
                        width: sizeOf.width * .55,
                        height: sizeOf.height * .08,
                        child: ElevatedButton(
                          onPressed: () {
                            final valid =
                                formKey.currentState?.validate() ?? false;

                            if (valid) {
                              print('Nome do Jogador: ${playerNameEC.text}');
                              print('Nome do Time: ${teamEC.text}');
                              print('Código do Torneio: ${tourneyCodeEC.text}');
                              print('...CADASTRAR PLAYER...');
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Cadastrar'.toUpperCase(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
