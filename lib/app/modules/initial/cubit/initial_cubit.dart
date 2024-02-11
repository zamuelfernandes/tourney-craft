import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/services/firestore.dart';
import 'initial_state.dart';

class InitialCubit extends Cubit<InitialState> {
  InitialCubit() : super(const InitialState());
  List<String> data = ['Ok'];
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
        data: data,
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
    required int tourneyCode,
  }) async {
    final result = await _firestoreService.createTourney(
      tourneyName: tourneyName,
      playersNumber: playersNumber,
      tourneyCode: tourneyCode,
    );

    return result;
  }

  Future<Map<String, dynamic>> getTourneyById({
    required String tourneyId,
  }) async {
    final tourneyData =
        await _firestoreService.getTourneyById(tourneyId: tourneyId);
    return tourneyData;
  }

  Future<String> regsisterPlayer({
    required String playerName,
    required String teamName,
    required String tourneyId,
  }) async {
    final tourney = await getTourneyById(
      tourneyId: tourneyId,
    );

    int playersQuant = tourney['playersNumber'];

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
}
