import 'package:equatable/equatable.dart';

class InitialState extends Equatable {
  //Estados da tela
  final bool isLoading;
  final bool isSuccess;
  final bool isError;

  //Auxiliar
  final String message;

  //Resultado Utilizado
  final String tourneyId;

  //Estados iniciais da tela
  const InitialState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.message = '',
    this.tourneyId = '',
  });

  InitialState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? message,
    String? tourneyId,
  }) {
    return InitialState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      message: message ?? this.message,
      tourneyId: tourneyId ?? this.tourneyId,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isError,
        message,
        tourneyId,
      ];
}
