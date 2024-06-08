



import 'package:bloc/bloc.dart';
import 'package:clean_arch_example/core/utils/storage_boxes.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../domain/entites/todo_entity.dart';
import '../../../domain/usecases/todo_usecasses.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetListTodoUsecase getListTodoUsecase;
  TodoCubit(this.getListTodoUsecase) : super(TodoInitial());

  List<TodoEntity> listTodo =[];

  remove(TodoEntity todo){

    listTodo.remove(todo);
emit(TodoLoaded(listTodo));

  }
  load() async {
    emit(TodoLoading());
    final response = await getListTodoUsecase
        .call(GetListTodoUsecaseParams(StorageBoxes.todos));
    response.fold(
      (l) => emit(TodoError(l.errorMassege)),
      (r) {
        final formatted = r;
        formatted.sort((a,b)=> b.createdAt.compareTo(a.createdAt),);
        listTodo = formatted;
        emit(TodoLoaded(formatted));
      },
    );
  }
  search(String? value){
    if (value == null || value.isEmpty) {
      load();
    }
    final List<TodoEntity> datas = listTodo.where(
          (element) {
        return element.title
            .toLowerCase()
            .contains(value!.toLowerCase());
      },
    ).toList();

    listTodo = datas;
    emit(TodoLoaded(listTodo));
  }
}
