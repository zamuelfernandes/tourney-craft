import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourney_craft/app/shared/services/tourney_repository.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';
import 'package:validatorless/validatorless.dart';
import '../../../shared/components/base_bottom_message.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/models/tourney.dart';
import '../../../shared/services/firestore.dart';
import 'complete_tourney_state.dart';

class CompleteTourneyCubit extends Cubit<CompleteTourneyState> {
  CompleteTourneyCubit() : super(const CompleteTourneyState());
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> getTourneyById({
    required String tourneyId,
  }) async {
    emit(state.copyWith(isLoading: true));
    //API CALL
    try {
      final tourneyData =
          await _firestoreService.getTourneyById(tourneyId: tourneyId);

      final tourney = TourneyModel.fromFirestore(tourneyData);

      //SUCCESS STATE
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        message: 'Success detected',
        tourney: tourney,
      ));
    } catch (e) {
      //ERROR STATE
      print(e.toString());
      !isClosed
          ? emit(state.copyWith(
              isLoading: false,
              isError: true,
              message: 'Error detected: ${e.toString()}',
            ))
          : null;
    }
  }

  void setGroupQuant({required int number}) {
    emit(state.copyWith(
      groupQuant: number,
      groupsList: List.generate(number, (index) => []),
    ));
  }

  void addPlayersDialog(
    BuildContext context, {
    required List<PlayerModel> players,
    required int selectedGroup,
  }) async {
    List<bool> selectedPlayers = List.generate(
      players.length,
      (index) => false,
    );

    List<PlayerModel> playersToAdd = [];

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Selecionar Jogadores'.toUpperCase(),
            textAlign: TextAlign.center,
            style: AppTextStyle.titleSmallStyle.copyWith(height: 1),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.4,
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: players.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhum jogador disponível',
                          style: TextStyle(
                            color: AppColors.secondaryBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: players.length,
                        itemBuilder: (context, index) {
                          final player = players[index];

                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.darkPrimary),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: RadioListTile<int>(
                              title: Text(
                                'Nome: ${player.playerName}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text('Time: ${player.teamName}'),
                              toggleable: true,
                              value: index,
                              groupValue: selectedPlayers[index] ? index : null,
                              onChanged: (selectedIndex) {
                                setState(() {
                                  selectedPlayers[index] =
                                      !selectedPlayers[index];

                                  if (selectedPlayers[index]) {
                                    playersToAdd.add(player);
                                  } else {
                                    playersToAdd.remove(player);
                                  }
                                });
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 15),
                      ),
              );
            },
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    emit(state.copyWith(
                      isLoading: true,
                      groupsList: state.groupsList
                        ..[selectedGroup - 1].addAll(playersToAdd),
                    ));
                    Navigator.pop(context);
                    emit(state.copyWith(
                      isLoading: false,
                    ));
                  },
                  child: Text(
                    'Adicionar\nSelecionados',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.subtitleStyle
                        .copyWith(height: 1, fontSize: 14),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Sair',
                    style: AppTextStyle.subtitleStyle
                        .copyWith(height: 1, fontSize: 14),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void removePlayer(
    BuildContext context, {
    required List<PlayerModel> players,
    required int selectedGroup,
  }) {
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Remover Jogador'.toUpperCase(),
            textAlign: TextAlign.center,
            style: AppTextStyle.titleSmallStyle.copyWith(height: 1),
          ),
          content: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.2,
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: ListView.separated(
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.darkPrimary),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(
                      'Nome: ${player.playerName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text('Time: ${player.teamName}'),
                    trailing: IconButton(
                      onPressed: () {
                        emit(state.copyWith(
                          isLoading: true,
                          groupsList: state.groupsList
                            ..[selectedGroup - 1].remove(player),
                        ));
                        Navigator.pop(context);
                        emit(state.copyWith(
                          isLoading: false,
                        ));
                      },
                      icon: const Icon(
                        Icons.close_sharp,
                        size: 30,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 15),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Sair',
                style: AppTextStyle.subtitleStyle
                    .copyWith(height: 1, fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
  }

  void registerPlayerDialog(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final playerNameEC = TextEditingController();
    final teamEC = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Cadastrar Jogador'.toUpperCase(),
            textAlign: TextAlign.center,
            style: AppTextStyle.titleSmallStyle.copyWith(height: 1),
          ),
          content: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.30,
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: playerNameEC,
                    validator: Validatorless.required('Campo obrigatório'),
                    decoration: InputDecoration(
                      label: Text('Nome do Jogador:'.toUpperCase()),
                    ),
                  ),
                  const SizedBox(height: 45),
                  TextFormField(
                    controller: teamEC,
                    validator: Validatorless.required('Campo obrigatório'),
                    decoration: InputDecoration(
                      label: Text('Nome do Time:'.toUpperCase()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                final valid = formKey.currentState?.validate() ?? false;
                final tourneyId = await TourneyRepository().getValue(
                  Constants.tourneyCodeFolder,
                );

                if (valid) {
                  Navigator.pop(context);

                  final result = await registerPlayer(
                    playerName: playerNameEC.text,
                    teamName: teamEC.text,
                    tourneyId: tourneyId!,
                  );

                  BaseBottomMessage.showMessage(
                    context,
                    result,
                    AppColors.secondaryBlack,
                  );
                }
              },
              child: Text(
                'Cadastrar',
                style: AppTextStyle.subtitleStyle
                    .copyWith(height: 1, fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Sair',
                style: AppTextStyle.subtitleStyle
                    .copyWith(height: 1, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String> registerPlayer({
    required String playerName,
    required String teamName,
    required String tourneyId,
  }) async {
    emit(state.copyWith(isLoading: true));

    try {
      final result = await _firestoreService.putPlayerInTourney(
        playerName: playerName,
        teamName: teamName,
        tourneyId: tourneyId,
      );

      getTourneyById(tourneyId: tourneyId);

      return result;
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        message: 'Erro ao cadastrar jogador: ${e.toString()}',
      ));
      return 'Erro ao cadastrar jogador: ${e.toString()}';
    }
  }
}
