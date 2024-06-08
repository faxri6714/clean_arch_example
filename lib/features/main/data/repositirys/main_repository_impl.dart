import 'package:clean_arch_example/core/entites/app_error.dart';
import 'package:clean_arch_example/core/usecasses/action.dart';
import 'package:clean_arch_example/features/main/data/datasources/main_local_data_sourse.dart';
import 'package:clean_arch_example/features/main/data/models/todo_model.dart';
import 'package:clean_arch_example/features/main/domain/entites/todo_entity.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositorys/main_repository.dart';

class MainRepositoryImpl implements MainRepository {
  final MainLocalDataSource localDataSource;

  MainRepositoryImpl(this.localDataSource);

  @override
  Future<Either<AppError, void>> deleteDataFromBox(String boxName) async {
    return action(task: localDataSource.deleteDataFromBox(boxName));
  }

  @override
  Future<Either<AppError, void>> deleteTodo(
      TodoEntity entity, String boxName) async {
    return action(
        task:
            localDataSource.deleteTodo(TodoModel.fromEntity(entity), boxName));
  }

  @override
  Future<Either<AppError, void>> deleteTodos(
      List<TodoEntity> data, String boxName) async {
    final listModels =
        data.map((element) => TodoModel.fromEntity(element)).toList();

    return action(task: localDataSource.deleteTodos(listModels, boxName));
  }

  @override
  Future<Either<AppError, List<TodoEntity>>> getListTodo(
      {required String boxName}) async {
    return action<List<TodoEntity>>(
        task: localDataSource.getListTodo(boxName: boxName));
  }

  @override
  Future<Either<AppError, void>> save(
    TodoEntity entity,
    String? boxName,
  ) async {
    final List<TodoModel> listTodo =
        await localDataSource.getListTodo();
    if (listTodo.isNotEmpty) {
      final todo =  listTodo.firstWhereOrNull((element) => element.id == entity.id);
      if(todo != null){
        return action<void>(
          task:
          localDataSource.updateTodo(TodoModel.fromEntity(entity)),
        );
      }

    }
    return action<void>(
        task: localDataSource.save(TodoModel.fromEntity(entity)));
  }

  @override
  Future<Either<AppError, void>> saveNewList(List<TodoEntity> listTodo) async {
    final listModels =
        listTodo.map((element) => TodoModel.fromEntity(element)).toList();
    return action(task: localDataSource.saveNewList(listModels));
  }

  @override
  Future<Either<AppError, void>> updateTodo(TodoEntity entity) async {
    return action(
        task: localDataSource.updateTodo(TodoModel.fromEntity(entity)));
  }
}
