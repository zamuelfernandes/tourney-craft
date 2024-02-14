import 'package:equatable/equatable.dart';
import 'package:tourney_craft/app/shared/models/tourney.dart';

class CompleteTourneyState extends Equatable {
  //Estados da tela
  final bool isLoading;
  final bool isSuccess;
  final bool isError;

  //Auxiliar
  final String message;

  //Resultado Utilizado
  final TourneyModel? tourney;
  final bool ready;

  //Estados iniciais da tela
  const CompleteTourneyState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.message = '',
    this.tourney,
    this.ready = false,
  });

  CompleteTourneyState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? message,
    TourneyModel? tourney,
    bool? ready,
  }) {
    return CompleteTourneyState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      message: message ?? this.message,
      tourney: tourney ?? this.tourney,
      ready: ready ?? this.ready,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isError,
        message,
        tourney,
        ready,
      ];
}
