import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tourney_craft/app/modules/complete_tourney/pages/matches_manage.dart';
import 'package:tourney_craft/app/modules/complete_tourney/pages/player_manage.dart';
import 'package:tourney_craft/app/modules/complete_tourney/widgets/switches_widgets.dart';
import 'package:tourney_craft/app/shared/components/base_bottom_message.dart';
import 'package:tourney_craft/app/shared/components/base_elevated_button.dart';
import 'package:tourney_craft/app/shared/constants/routes.dart';
import 'package:tourney_craft/app/shared/services/tourney_repository.dart';
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
  bool loosersOption = false;
  bool quartersOption = true;
  bool octavesOption = false;
  bool winnerLowerOption = false;

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  void initState() {
    _cubit = CompleteTourneyCubit()
      ..loadData(
        tourneyId: widget.tourneyId,
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: BaseAppBar(
        actions: [
          IconButton(
            onPressed: () {
              TourneyRepository().clearAllValues();
              Modular.to.pushReplacementNamed(Routes.initial);
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
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
                            height: sizeOf.height * 0.08,
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
                          SizedBox(height: sizeOf.height * .03),
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
                          SizedBox(height: sizeOf.height * .03),
                          Center(
                            child: SwitchesWidgets(
                              playersQuant: state.tourney!.players.length,
                              loosersOption: loosersOption,
                              winnerLowerOption: winnerLowerOption,
                              quartersOption: quartersOption,
                              octavesOption: octavesOption,
                            ),
                          ),
                          SizedBox(height: sizeOf.height * .03),
                          BaseElevatedButton(
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
                            label: 'Organizar Grupos',
                          ),
                          const SizedBox(height: 20),
                          BaseElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PlayerManagePage(
                                  cubit: _cubit,
                                ),
                              ));
                            },
                            label: 'Gerenciar Jogadores',
                          ),
                          const SizedBox(height: 20),
                          BaseElevatedButton(
                            onPressed: () {
                              final groupsQuant = List<int>.generate(
                                state.groupQuant,
                                (index) => index + 1,
                              );

                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MatchesManagePage(
                                  cubit: _cubit,
                                  groups: groupsQuant,
                                  selectedGroup: groupsQuant.first,
                                ),
                              ));
                            },
                            label: 'Ver Tabelamento',
                          ),
                          const SizedBox(height: 20),
                          BaseElevatedButton(
                            onPressed: () {
                              if (!_cubit.allReady()) {
                                BaseBottomMessage.showMessage(
                                  context,
                                  'Configurações Faltantes',
                                  AppColors.secondaryBlack,
                                );
                              } else {
                                // _cubit.updateTourneyStatus(
                                //   tourneyId: tourney.tourneyId,
                                //   status: 1,
                                // );
                                BaseBottomMessage.showMessage(
                                  context,
                                  'Tudo Certo',
                                  AppColors.secondaryBlack,
                                );
                              }
                            },
                            label: 'Iniciar Torneio',
                            color: AppColors.checkColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: sizeOf.height * 0.08,
                        child: Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Text('Tourney Craft © 2024'),
                        ),
                      ),
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
