import 'package:equatable/equatable.dart';

class CreateTourneyState extends Equatable {
  //Estados da tela
  final bool isLoading;
  final bool isSuccess;
  final bool isError;

  //Auxiliar
  final String message;

  //Resultado Utilizado
  final List<String> data;

  //Estados iniciais da tela
  const CreateTourneyState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.message = '',
    this.data = const [],
  });

  CreateTourneyState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? message,
    List<String>? data,
  }) {
    return CreateTourneyState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isError,
        message,
        data,
      ];
}
