

import 'package:clean_arch_example/core/entites/app_error.dart';
import 'package:dartz/dartz.dart';

import '../entites/todo_entity.dart';

abstract class MainRepository{


  Future<Either<AppError,void>> save(TodoEntity entity ,String? boxName);
  Future<Either<AppError,void >> saveNewList(List<TodoEntity> listTodo);
  Future<Either<AppError, List<TodoEntity>>> getListTodo({required String boxName});
  Future<Either<AppError,void>>updateTodo(TodoEntity entity);
  Future<Either<AppError,void>> deleteTodos(List<TodoEntity> data,String boxName);
  Future<Either<AppError,void>> deleteTodo(TodoEntity entity,String boxName);
  Future<Either<AppError,void>> deleteDataFromBox(String boxName);

}