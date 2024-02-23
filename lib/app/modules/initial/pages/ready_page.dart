// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourney_craft/app/shared/components/base_elevated_button.dart';
import 'package:validatorless/validatorless.dart';

import 'package:tourney_craft/app/modules/initial/cubit/initial_cubit.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';

import '../../../shared/components/base_app_bar.dart';
import '../cubit/initial_state.dart';

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
  final tourneyIdEC = TextEditingController();
  final adminPasswordEC = TextEditingController();
  bool isAdm = false;

  @override
  void dispose() {
    tourneyIdEC.dispose();
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
          builder: (context, state) {
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
                          const SizedBox(height: 25),
                          TextFormField(
                            controller: tourneyIdEC,
                            validator:
                                Validatorless.required('Campo obrigatório'),
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
                                      ? AppColors.black
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
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox.adaptive(
                                  value: isAdm,
                                  onChanged: (value) {
                                    setState(() {
                                      isAdm = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'Sou Administrador',
                                  style: AppTextStyle.subtitleStyle
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Hero(
                            tag: 'Ready',
                            child: BaseElevatedButton(
                              onPressed: () async {
                                final valid =
                                    formKey.currentState?.validate() ?? false;

                                if (valid) {
                                  widget.cubit.loginTourney(
                                    context,
                                    tourneyId: tourneyIdEC.text,
                                    adminPassword: adminPasswordEC.text,
                                    isAdm: isAdm,
                                  );
                                }
                              },
                              label: 'Entrar',
                              labelWidget: state.isLoading
                                  ? const CircularProgressIndicator(
                                      color: AppColors.white)
                                  : null,
                              color: AppColors.checkColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
