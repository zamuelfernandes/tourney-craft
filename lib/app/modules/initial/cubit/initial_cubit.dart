import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/services/firestore.dart';
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

  Future<void> createTourney({
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
      message: result.message,
      tourneyId: result.tourneyId,
    ));
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
    final tourney = await getTourneyById(
      tourneyId: tourneyId,
    );

    int playersQuant = tourney['playersNumber'];

    if (tourney['players'].length == playersQuant - 1) {
      await _firestoreService.updateTourneyStatus(
        tourneyId: tourneyId,
        status: 1,
      );
    }

    if (await _firestoreService.doesIdExist(documentId: tourneyId)) {
      if (tourney['players'] == null ||
          tourney['players'].length < playersQuant) {
        final result = await _firestoreService.putPlayerInTourney(
          playerName: playerName,
          teamName: teamName,
          tourneyId: tourneyId,
        );

        return result;
      }
    } else {
      return 'Torneio não encontrado!';
    }

    return 'Torneio lotado!';
  }

  Future<bool> doesIdExist({required String documentId}) async {
    return await _firestoreService.doesIdExist(documentId: documentId);
  }
}
