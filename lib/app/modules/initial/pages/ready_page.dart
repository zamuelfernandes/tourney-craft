import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validatorless/validatorless.dart';

import '../../../shared/components/base_app_bar.dart';

class ReadyPage extends StatefulWidget {
  const ReadyPage({super.key});

  @override
  State<ReadyPage> createState() => _ReadyPageState();
}

class _ReadyPageState extends State<ReadyPage> {
  final formKey = GlobalKey<FormState>();
  final tourneyCodeEC = TextEditingController();

  @override
  void dispose() {
    tourneyCodeEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Entrar no Torneio',
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
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: tourneyCodeEC,
                      validator: Validatorless.required('Campo obrigatório'),
                      decoration: InputDecoration(
                        label: Text('Código do Torneio:'.toUpperCase()),
                      ),
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    const SizedBox(height: 80),
                    Hero(
                      tag: 'Ready',
                      child: SizedBox(
                        width: sizeOf.width * .55,
                        height: sizeOf.height * .08,
                        child: ElevatedButton(
                          onPressed: () {
                            final valid =
                                formKey.currentState?.validate() ?? false;

                            if (valid) {
                              print('Código do Torneio: ${tourneyCodeEC.text}');
                              print('...CADASTRAR PLAYER...');
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Entrar'.toUpperCase(),
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
