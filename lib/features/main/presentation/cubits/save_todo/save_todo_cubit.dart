import 'package:bloc/bloc.dart';
import 'package:clean_arch_example/core/utils/storage_boxes.dart';
import 'package:clean_arch_example/features/main/domain/entites/todo_entity.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/todo_usecasses.dart';

part 'save_todo_state.dart';

class SaveTodoCubit extends Cubit<SaveTodoState> {
  final SaveTodoUsecase saveTodoUsecase;
  SaveTodoCubit(this.saveTodoUsecase) : super(SaveTodoInitial());

  save(TodoEntity entity) async {
    emit(SaveTodoLoading());
    final response =
        await saveTodoUsecase.call(SaveTodoUsecaseParams(entity,StorageBoxes.todos));
    response.fold(
      (l) => emit(SaveTodoError(l.errorMassege)),
      (r) => emit(SaveTodoSaved()),
    );

    await Future.delayed(const Duration(seconds: 1));

    emit(SaveTodoInitial());
  }
}
