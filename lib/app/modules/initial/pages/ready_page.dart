// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tourney_craft/app/shared/components/base_bottom_message.dart';
import 'package:tourney_craft/app/shared/constants/routes.dart';
import 'package:validatorless/validatorless.dart';

import 'package:tourney_craft/app/modules/initial/cubit/initial_cubit.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';

import '../../../shared/components/base_app_bar.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/services/tourney_repository.dart';

class ReadyPage extends StatefulWidget {
  final InitialCubit cubit;
  const ReadyPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ReadyPage> createState() => _ReadyPageState();
}

class _ReadyPageState extends State<ReadyPage> {
  final formKey = GlobalKey<FormState>();
  final tourneyId = TextEditingController();
  final adminPasswordEC = TextEditingController();
  bool isAdm = false;

  @override
  void dispose() {
    tourneyId.dispose();
    adminPasswordEC.dispose();
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
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: tourneyId,
                      validator: Validatorless.required('Campo obrigatório'),
                      decoration: InputDecoration(
                        label: Text('Código do Torneio:'.toUpperCase()),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: adminPasswordEC,
                      enabled: isAdm,
                      validator: isAdm
                          ? Validatorless.required('Campo obrigatório')
                          : null,
                      decoration: InputDecoration(
                        label: Text(
                          'Senha de ADM'.toUpperCase(),
                          style: TextStyle(
                            color: isAdm
                                ? AppColors.darkPrimary
                                : AppColors.lightPrimary,
                          ),
                        ),
                      ),
                      maxLength: 8,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    const SizedBox(height: 80),
                    SizedBox(
                      width: sizeOf.width * .7,
                      child: CheckboxListTile.adaptive(
                        value: isAdm,
                        onChanged: (value) {
                          setState(() {
                            isAdm = value!;
                          });
                        },
                        activeColor: AppColors.secondaryBlack,
                        title: const Text('Sou Administrador'),
                      ),
                    ),
                    Hero(
                      tag: 'Ready',
                      child: SizedBox(
                        width: sizeOf.width * .55,
                        height: sizeOf.height * .08,
                        child: ElevatedButton(
                          onPressed: () async {
                            final valid =
                                formKey.currentState?.validate() ?? false;

                            if (valid) {
                              if (await widget.cubit.doesIdExist(
                                documentId: tourneyId.text,
                              )) {
                                final tourney =
                                    await widget.cubit.getTourneyById(
                                  tourneyId: tourneyId.text,
                                );

                                if (!isAdm && tourney['status'] == 2) {
                                  print('GO TO DASHBOARD');
                                  final folderRepository = TourneyRepository();

                                  await folderRepository.saveValue(
                                    Constants.tourneyCodeFolder,
                                    tourneyId.text,
                                  );
                                  await folderRepository.saveValue(
                                    Constants.admPasswordFolder,
                                    adminPasswordEC.text,
                                  );
                                  await folderRepository.saveValue(
                                    Constants.tourneyStatusFolder,
                                    tourney['status'].toString(),
                                  );
                                } else if (!isAdm) {
                                  BaseBottomMessage.showMessage(
                                    context,
                                    'Torneio ainda não iniciado!',
                                    AppColors.secondaryBlack,
                                  );
                                }

                                if (isAdm &&
                                    tourney['adminPassword'] ==
                                        int.parse(adminPasswordEC.text)) {
                                  if (tourney['status'] == 1) {
                                    final folderRepository =
                                        TourneyRepository();

                                    await folderRepository.saveValue(
                                      Constants.tourneyCodeFolder,
                                      tourneyId.text,
                                    );
                                    await folderRepository.saveValue(
                                      Constants.admPasswordFolder,
                                      adminPasswordEC.text,
                                    );
                                    await folderRepository.saveValue(
                                      Constants.tourneyStatusFolder,
                                      tourney['status'].toString(),
                                    );

                                    Modular.to.pushNamed(
                                      Routes.completeTourney,
                                      arguments: tourneyId.text,
                                    );
                                  } else if (tourney['status'] == 0) {
                                    BaseBottomMessage.showMessage(
                                      context,
                                      'Cadastros dos Jogadores \nainda não finalizados!',
                                      AppColors.secondaryBlack,
                                    );
                                  } else {
                                    print('GO TO DASHBOARD');
                                    final folderRepository =
                                        TourneyRepository();

                                    await folderRepository.saveValue(
                                      Constants.tourneyCodeFolder,
                                      tourneyId.text,
                                    );
                                    await folderRepository.saveValue(
                                      Constants.admPasswordFolder,
                                      adminPasswordEC.text,
                                    );
                                    await folderRepository.saveValue(
                                      Constants.tourneyStatusFolder,
                                      tourney['status'].toString(),
                                    );
                                  }
                                } else if (isAdm) {
                                  BaseBottomMessage.showMessage(
                                    context,
                                    'Senha incorreta!',
                                    AppColors.secondaryBlack,
                                  );
                                }
                              } else {
                                BaseBottomMessage.showMessage(
                                  context,
                                  'Torneio não encontrado!',
                                  AppColors.secondaryBlack,
                                );
                              }
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
