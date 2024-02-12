import 'package:flutter_bloc/flutter_bloc.dart';
import 'complete_tourney_state.dart';

class CompleteTourneyCubit extends Cubit<CompleteTourneyState> {
  CompleteTourneyCubit() : super(const CompleteTourneyState());
  List<String> data = ['Ok'];

  void fetchData() async {
    emit(state.copyWith(isLoading: true));
    //API CALL
    try {
      await Future.delayed(Duration(seconds: 3));

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
}
