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

  //Estados iniciais da tela
  const CompleteTourneyState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.message = '',
    this.tourney,
  });

  CompleteTourneyState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? message,
    TourneyModel? tourney,
  }) {
    return CompleteTourneyState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      message: message ?? this.message,
      tourney: tourney ?? this.tourney,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isError,
        message,
        tourney,
      ];
}
