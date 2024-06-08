import 'package:clean_arch_example/core/entites/app_error.dart';
import 'package:clean_arch_example/core/usecasses/usecasses.dart';
import 'package:clean_arch_example/core/utils/storage_boxes.dart';
import 'package:clean_arch_example/features/main/domain/entites/todo_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositorys/main_repository.dart';

class GetListTodoUsecase extends UseCase<List<TodoEntity> ,GetListTodoUsecaseParams>{
  final MainRepository repository;

  GetListTodoUsecase({required this.repository});
  @override
  Future<Either<AppError, List<TodoEntity>>> call(GetListTodoUsecaseParams params) {
    return repository.getListTodo(boxName: params.boxName);
  }

}

class SaveTodoUsecase extends UseCase<void,SaveTodoUsecaseParams>{
  final MainRepository repository;

  SaveTodoUsecase(this.repository);

  @override
  Future<Either<AppError, void>> call(SaveTodoUsecaseParams params) {
   return repository.save(params.entity,params.boxName);
  }
  
}


class DeleteTodoUsecase extends UseCase<void,DeleteTodoUsecaseParams>{
  final MainRepository repository;

  DeleteTodoUsecase(this.repository);

  @override
  Future<Either<AppError, void>> call(DeleteTodoUsecaseParams params) {
    return repository.deleteTodo(params.entity, params.boxName);
  }

}







class GetListTodoUsecaseParams{
  final String boxName;

  GetListTodoUsecaseParams(this.boxName);
}

 class SaveTodoUsecaseParams{
  final TodoEntity entity;
  final String boxName;

  SaveTodoUsecaseParams(this.entity, this.boxName);


}
class DeleteTodoUsecaseParams{
  final TodoEntity entity;
  final String boxName;


  DeleteTodoUsecaseParams(this.entity, this.boxName);


}


