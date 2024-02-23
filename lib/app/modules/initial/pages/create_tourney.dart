import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourney_craft/app/modules/initial/cubit/initial_cubit.dart';
import 'package:tourney_craft/app/modules/initial/cubit/initial_state.dart';
import 'package:tourney_craft/app/shared/components/base_app_bar.dart';
import 'package:tourney_craft/app/shared/components/base_bottom_message.dart';
import 'package:tourney_craft/app/shared/components/base_elevated_button.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';
import 'package:validatorless/validatorless.dart';

class CreateTourneyPage extends StatefulWidget {
  final InitialCubit cubit;
  const CreateTourneyPage({
    super.key,
    required this.cubit,
  });

  @override
  State<CreateTourneyPage> createState() => _CreateTourneyPageState();
}

class _CreateTourneyPageState extends State<CreateTourneyPage> {
  final formKey = GlobalKey<FormState>();
  final tourneyNameEC = TextEditingController();
  final playersNumberEC = TextEditingController();
  final adminPasswordEC = TextEditingController();

  @override
  void dispose() {
    tourneyNameEC.dispose();
    playersNumberEC.dispose();
    adminPasswordEC.dispose();
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
      body: BlocConsumer<InitialCubit, InitialState>(
        bloc: widget.cubit,
        listener: (context, state) {
          if (state.isSuccess) {
            //faz algo
          }

          if (state.isError) {
            //faz algo
          }
        },
        builder: ((context, state) {
          return SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: sizeOf.height * .7,
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
                          validator:
                              Validatorless.required('Campo obrigatório'),
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
                          validator:
                              Validatorless.required('Campo obrigatório'),
                          decoration: InputDecoration(
                            label: Text('Número de Jogadores:'.toUpperCase()),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          controller: adminPasswordEC,
                          validator:
                              Validatorless.required('Campo obrigatório'),
                          decoration: InputDecoration(
                            label: Text('Senha dos ADM:'.toUpperCase()),
                          ),
                          maxLength: 8,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        const SizedBox(height: 40),
                        Hero(
                          tag: 'createTourney',
                          child: BaseElevatedButton(
                            onPressed: () async {
                              final valid =
                                  formKey.currentState?.validate() ?? false;

                              if (valid) {
                                if (int.parse(playersNumberEC.text) < 4) {
                                  BaseBottomMessage.showMessage(
                                    context,
                                    'O número mínimo de jogadores é 8!',
                                    AppColors.secondaryBlack,
                                  );
                                } else {
                                  final result =
                                      await widget.cubit.createTourney(
                                    tourneyName: tourneyNameEC.text,
                                    playersNumber:
                                        int.parse(playersNumberEC.text),
                                    adminPassword:
                                        int.parse(adminPasswordEC.text),
                                  );

                                  BaseBottomMessage.showMessage(
                                    context,
                                    result,
                                    AppColors.secondaryBlack,
                                  );
                                }
                              }
                            },
                            label: 'Criar',
                            labelWidget: state.isLoading
                                ? const CircularProgressIndicator(
                                    color: AppColors.white,
                                  )
                                : null,
                          ),
                        ),
                        state.tourneyId.isNotEmpty
                            ? SelectableText('ID: ${state.tourneyId}')
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
