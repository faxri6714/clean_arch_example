import 'dart:io';

import 'package:dartz/dartz.dart';

import '../api/api_exception.dart';
import '../entites/app_error.dart';

Future<Either<AppError, T>> action<T>({required Future<T> task}) async {
  try {
    final response = await task;

  return Right(response);
  } on SocketException {
  return const Left(AppError(appErrorType: AppErrorType.network));
  } on UnauthorisedException {
  return const Left(AppError(appErrorType: AppErrorType.unauthorised));
  } on ExceptionWithMessage catch (e) {
  return Left(
  AppError(appErrorType: AppErrorType.msgError, errorMassege: e.message));
  } on Exception {
  return const Left(AppError(appErrorType: AppErrorType.api));
  }
}