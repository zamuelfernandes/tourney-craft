import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_tourney_state.dart';

class CreateTourneyCubit extends Cubit<CreateTourneyState> {
  CreateTourneyCubit() : super(const CreateTourneyState());
  List<String> data = ['Ok'];

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
}
