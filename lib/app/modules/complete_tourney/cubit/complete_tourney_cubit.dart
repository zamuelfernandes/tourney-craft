import 'package:flutter_bloc/flutter_bloc.dart';
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

      print(tourney);

      //SUCCESS STATE
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        message: 'Success detected',
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
}
