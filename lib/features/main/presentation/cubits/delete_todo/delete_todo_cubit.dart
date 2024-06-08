import 'package:bloc/bloc.dart';
import 'package:clean_arch_example/core/utils/storage_boxes.dart';
import 'package:clean_arch_example/features/main/domain/entites/todo_entity.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/todo_usecasses.dart';
import '../todo/todo_cubit.dart';

part 'delete_todo_state.dart';

class DeleteTodoCubit extends Cubit<DeleteTodoState> {
  final DeleteTodoUsecase deleteTodoUsecase;

  DeleteTodoCubit(this.deleteTodoUsecase,)
      : super(DeleteTodoInitial());

  delete(TodoEntity entity) async {
    emit(DeleteTodoLoading());
    final response = await deleteTodoUsecase
        .call(DeleteTodoUsecaseParams(entity, StorageBoxes.todos));

    response.fold(
      (l) => emit(DeleteTodoError(l.errorMassege)),
      (r) {
        emit(DeleteTodoSuccess(entity));

      },
    );
  }
}
