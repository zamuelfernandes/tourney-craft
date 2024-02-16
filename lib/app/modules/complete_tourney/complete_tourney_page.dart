import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourney_craft/app/modules/complete_tourney/pages/player_manage.dart';
import 'package:tourney_craft/app/shared/components/base_bottom_message.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';
import 'package:validatorless/validatorless.dart';
import '../../shared/components/base_app_bar.dart';
import 'cubit/complete_tourney_cubit.dart';
import 'cubit/complete_tourney_state.dart';
import 'pages/group_manage.dart';

class CompleteTourneyPage extends StatefulWidget {
  final String tourneyId;
  const CompleteTourneyPage({
    super.key,
    required this.tourneyId,
  });

  @override
  _CompleteTourneyPageState createState() => _CompleteTourneyPageState();
}

class _CompleteTourneyPageState extends State<CompleteTourneyPage> {
  late CompleteTourneyCubit _cubit;
  final groupQuantEC = TextEditingController();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  void initState() {
    _cubit = CompleteTourneyCubit()
      ..getTourneyById(
        tourneyId: widget.tourneyId,
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: BaseAppBar(),
      body: BlocConsumer<CompleteTourneyCubit, CompleteTourneyState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state.isSuccess) {
            //faz algo
          }

          if (state.isError) {
            //faz algo
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return SizedBox(
              height: sizeOf.height * 0.55,
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          }

          if (state.isSuccess) {
            final tourney = state.tourney!;
            return Center(
              child: Container(
                height: sizeOf.height * 0.85,
                constraints: BoxConstraints(maxWidth: sizeOf.width * .85),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: sizeOf.height * 0.1,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    tourney.tourneyName.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Finalizar organização\ndo torneio'
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: sizeOf.height * .07),
                          TextFormField(
                            controller: groupQuantEC,
                            validator:
                                Validatorless.required('Campo obrigatório'),
                            decoration: InputDecoration(
                              label:
                                  Text('Quantidade de grupos:'.toUpperCase()),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (int.parse(groupQuantEC.text) < 1) {
                                    BaseBottomMessage.showMessage(
                                      context,
                                      'Informe uma quantidade\nde grupos válida',
                                      AppColors.secondaryBlack,
                                    );
                                  } else if (int.parse(groupQuantEC.text) >
                                      state.tourney!.players.length) {
                                    BaseBottomMessage.showMessage(
                                      context,
                                      'Quantidade de grupos maior que\na quantidade de jogadores',
                                      AppColors.secondaryBlack,
                                    );
                                  } else {
                                    BaseBottomMessage.showMessage(
                                      context,
                                      'Quantidade de grupos\nconfigurada com sucesso',
                                      AppColors.secondaryBlack,
                                    );

                                    _cubit.setGroupQuant(
                                      number: int.parse(groupQuantEC.text),
                                    );

                                    SystemChannels.textInput
                                        .invokeMethod('TextInput.hide');
                                  }
                                },
                                icon: Card(
                                  shape: CircleBorder(),
                                  color: AppColors.secondaryBlack,
                                  elevation: 3,
                                  child: Icon(
                                    Icons.check_circle,
                                    size: 35,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: sizeOf.height * .07),
                          SizedBox(
                            width: sizeOf.width * .55,
                            height: sizeOf.height * .08,
                            child: ElevatedButton(
                              onPressed: () {
                                if (state.groupQuant < 1) {
                                  BaseBottomMessage.showMessage(
                                    context,
                                    'Informe antes\na quantidade de grupos',
                                    AppColors.secondaryBlack,
                                  );
                                } else {
                                  final groupsQuant = List<int>.generate(
                                    state.groupQuant,
                                    (index) => index + 1,
                                  );

                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => GroupManagePage(
                                      cubit: _cubit,
                                      groups: groupsQuant,
                                      selectedGroup: groupsQuant.first,
                                      playersList: tourney.players,
                                    ),
                                  ));
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  'Organizar Grupos'.toUpperCase(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: sizeOf.width * .55,
                            height: sizeOf.height * .08,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PlayerManagePage(
                                    cubit: _cubit,
                                  ),
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  'Gerenciar Jogadores'.toUpperCase(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: sizeOf.width * .55,
                            height: sizeOf.height * .08,
                            child: ElevatedButton(
                              onPressed: () {
                                if (!state.ready) {
                                  BaseBottomMessage.showMessage(
                                    context,
                                    'Configurações Faltantes',
                                    AppColors.secondaryBlack,
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text('Iniciar Torneio'.toUpperCase()),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: sizeOf.height * 0.15,
                      ),
                      Text('Tourney Craft © 2024'),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state.isError) {
            return SizedBox(
              height: sizeOf.height * 0.55,
              width: sizeOf.width * 0.75,
              child: Center(
                child: SelectableText(
                  state.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
