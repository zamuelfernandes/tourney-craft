import 'package:flutter/material.dart';
import 'package:tourney_craft/app/shared/components/base_app_bar.dart';
import 'package:validatorless/validatorless.dart';

class CreateTourneyPage extends StatefulWidget {
  const CreateTourneyPage({super.key});

  @override
  State<CreateTourneyPage> createState() => _CreateTourneyPageState();
}

class _CreateTourneyPageState extends State<CreateTourneyPage> {
  final formKey = GlobalKey<FormState>();
  final tourneyNameEC = TextEditingController();
  final playersNumberEC = TextEditingController();

  @override
  void dispose() {
    tourneyNameEC.dispose();
    playersNumberEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Criar Torneio',
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
                      controller: tourneyNameEC,
                      validator: Validatorless.required('Campo obrigatório'),
                      // Validatorless.multiple([
                      //   Validatorless.required('E-mail obrigatório'),
                      //   Validatorless.email('E-mail inválido'),
                      // ]),
                      decoration: InputDecoration(
                        label: Text('Nome do Torneio:'.toUpperCase()),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: playersNumberEC,
                      validator: Validatorless.required('Campo obrigatório'),
                      decoration: InputDecoration(
                        label: Text('Número de Jogadores:'.toUpperCase()),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 40),
                    Hero(
                      tag: 'createTourney',
                      child: SizedBox(
                        width: sizeOf.width * .55,
                        height: sizeOf.height * .08,
                        child: ElevatedButton(
                          onPressed: () {
                            final valid =
                                formKey.currentState?.validate() ?? false;

                            if (valid) {
                              print('Torneio: ${tourneyNameEC.text}');
                              print('Jogadores: ${playersNumberEC.text}');
                              print('...CRIAR TORNEIO...');
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text('Criar'.toUpperCase()),
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
