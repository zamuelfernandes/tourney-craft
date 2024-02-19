import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/components/base_bottom_message.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/constants/routes.dart';
import '../../../shared/services/firestore.dart';
import '../../../shared/services/tourney_repository.dart';
import '../../../shared/themes/themes.dart';
import 'initial_state.dart';

class InitialCubit extends Cubit<InitialState> {
  InitialCubit() : super(const InitialState());
  final FirestoreService _firestoreService = FirestoreService();

  void fetchData() async {
    emit(state.copyWith(isLoading: true));
    //API CALL
    try {
      await Future.delayed(const Duration(seconds: 3));

      //SUCCESS STATE
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        message: 'Success detected',
      ));
    } catch (e) {
      //ERROR STATE
      !isClosed
          ? emit(state.copyWith(
              isLoading: false,
              isError: true,
              message: 'Error detected: ${e.toString()}',
            ))
          : null;
    }
  }

  Future<String> createTourney({
    required String tourneyName,
    required int playersNumber,
    required int adminPassword,
  }) async {
    emit(state.copyWith(isLoading: true));

    final result = await _firestoreService.createTourney(
      tourneyName: tourneyName,
      playersNumber: playersNumber,
      adminPassword: adminPassword,
    );

    emit(state.copyWith(
      isLoading: false,
      isSuccess: true,
      tourneyId: result.tourneyId,
    ));

    return result.message;
  }

  Future<Map<String, dynamic>> getTourneyById({
    required String tourneyId,
  }) async {
    final tourneyData =
        await _firestoreService.getTourneyById(tourneyId: tourneyId);
    return tourneyData;
  }

  Future<String> registerPlayer({
    required String playerName,
    required String teamName,
    required String tourneyId,
  }) async {
    emit(state.copyWith(isLoading: true));

    try {
      final tourney = await getTourneyById(
        tourneyId: tourneyId,
      );

      int playersQuant = tourney['playersNumber'];

      final firebasePlayerQuant =
          await _firestoreService.contarDocumentos(tourneyId, 'playersList');

      if (await _firestoreService.doesIdExist(documentId: tourneyId)) {
        if (firebasePlayerQuant < playersQuant) {
          final result = await _firestoreService.putPlayerInTourney(
            playerName: playerName,
            teamName: teamName,
            tourneyId: tourneyId,
          );

          if (firebasePlayerQuant == playersQuant - 1) {
            await _firestoreService.updateTourneyStatus(
              tourneyId: tourneyId,
              status: 1,
            );
          }

          emit(state.copyWith(isLoading: false));
          return result;
        }
      } else {
        emit(state.copyWith(isLoading: false));
        return 'Torneio não encontrado!';
      }

      emit(state.copyWith(isLoading: false));
      return 'Torneio lotado!';
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        message: 'Erro ao cadastrar jogador: ${e.toString()}',
      ));
      return 'Erro ao cadastrar jogador: ${e.toString()}';
    }
  }

  Future<bool> doesIdExist({required String documentId}) async {
    return await _firestoreService.doesIdExist(documentId: documentId);
  }

  Future<void> loginTourney(
    BuildContext context, {
    required String tourneyId,
    required String adminPassword,
    required bool isAdm,
  }) async {
    emit(state.copyWith(isLoading: true));

    try {
      if (await doesIdExist(
        documentId: tourneyId,
      )) {
        final tourney = await getTourneyById(
          tourneyId: tourneyId,
        );

        if (!isAdm && tourney['status'] == 2) {
          print('============ GO TO DASHBOARD ============');
          final folderRepository = TourneyRepository();

          await folderRepository.saveValue(
            Constants.tourneyCodeFolder,
            tourneyId,
          );
          await folderRepository.saveValue(
            Constants.tourneyStatusFolder,
            tourney['status'].toString(),
          );
          emit(state.copyWith(isLoading: false));
        } else if (!isAdm) {
          BaseBottomMessage.showMessage(
            context,
            'Torneio ainda não iniciado!',
            AppColors.secondaryBlack,
          );

          emit(state.copyWith(isLoading: false));
        }

        if (isAdm && tourney['adminPassword'] == int.parse(adminPassword)) {
          if (tourney['status'] == 1) {
            final folderRepository = TourneyRepository();

            await folderRepository.saveValue(
              Constants.tourneyCodeFolder,
              tourneyId,
            );
            await folderRepository.saveValue(
              Constants.admPasswordFolder,
              adminPassword,
            );
            await folderRepository.saveValue(
              Constants.tourneyStatusFolder,
              tourney['status'].toString(),
            );

            emit(state.copyWith(isLoading: false));
            Modular.to.pushReplacementNamed(
              Routes.completeTourney,
              arguments: tourneyId,
            );
          } else if (tourney['status'] == 0) {
            BaseBottomMessage.showMessage(
              context,
              'Cadastros dos Jogadores \nainda não finalizados!',
              AppColors.secondaryBlack,
            );

            emit(state.copyWith(isLoading: false));
          } else {
            print('============ GO TO DASHBOARD ============');
            final folderRepository = TourneyRepository();

            await folderRepository.saveValue(
              Constants.tourneyCodeFolder,
              tourneyId,
            );
            await folderRepository.saveValue(
              Constants.admPasswordFolder,
              adminPassword,
            );
            await folderRepository.saveValue(
              Constants.tourneyStatusFolder,
              tourney['status'].toString(),
            );
            emit(state.copyWith(isLoading: false));
          }
        } else if (isAdm) {
          BaseBottomMessage.showMessage(
            context,
            'Senha incorreta!',
            AppColors.secondaryBlack,
          );

          emit(state.copyWith(isLoading: false));
        }
      } else {
        BaseBottomMessage.showMessage(
          context,
          'Torneio não encontrado!',
          AppColors.secondaryBlack,
        );

        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        message: 'Erro ao entrar no torneio: ${e.toString()}',
      ));
    }
  }
}
