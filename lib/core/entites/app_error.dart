import 'package:equatable/equatable.dart';

class AppError extends Equatable{
  final AppErrorType appErrorType;
  final String errorMassege;

  const AppError({required this.appErrorType,  this.errorMassege = ""});

  @override

  List<Object?> get props => throw UnimplementedError();



}

enum AppErrorType{
  api,
  network,
  database,
  unauthorised,
  sessionDenied,
  msgError,
  emailValidation,
}