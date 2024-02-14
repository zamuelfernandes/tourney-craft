import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourney_craft/app/shared/components/base_bottom_message.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';
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
            return SizedBox(
              height: sizeOf.height * 0.85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                'Gerencia do torneio',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: sizeOf.height * .15),
                      SizedBox(
                        width: sizeOf.width * .55,
                        height: sizeOf.height * .08,
                        child: ElevatedButton(
                          onPressed: () {
                            final groupsQuant =
                                List<int>.generate(8, (index) => index + 1);

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GroupManagePage(
                                groups: groupsQuant,
                                selectedGroup: groupsQuant.first,
                                playersList: tourney.players,
                              ),
                            ));
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
                          onPressed: () {},
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
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Text('Tourney Craft © 2021'),
                  )
                ],
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
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     //faz algo
      //   },
      //   label: Text('Add Player'),
      //   icon: Icon(Icons.add),
      // ),
    );
  }
}
