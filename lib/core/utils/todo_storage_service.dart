import 'package:clean_arch_example/core/utils/storage_boxes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../features/main/data/models/todo_model.dart';






class TodoStorageService {



 // TodoStorageService(){
 //   deleteAll();
 // }


  save(TodoModel entity, {String? boxName}) async {
    final box = await Hive.openBox(boxName ?? StorageBoxes.todos);

    final model = TodoModel.fromEntity(entity);
    debugPrint("Added data $model to box ${boxName ?? StorageBoxes.todos}");

    await box.add(model.toJson());
  }

  saveNewList(List<TodoModel> listTodo) async {
    final box = await Hive.openBox(StorageBoxes.todos);

    await box.clear();

    final List<Map<String, dynamic>> listJson = listTodo
        .map((element) => TodoModel.fromEntity(element).toJson())
        .toList();

    debugPrint("Remove data from box ${StorageBoxes.todos} ${listJson.length}");

    await box.addAll(listJson);
  }

  Future<List<TodoModel>> getListTodo({String? boxName}) async {
    final box = await Hive.openBox(boxName ?? StorageBoxes.todos);

    final listJson = List.from(box.values);

    final List<TodoModel> listData = [];
    for (var json in listJson) {
      listData.add(TodoModel.fromJson(Map<String, dynamic>.from(json)));
    }

    debugPrint("List data ${listData.length}");

    return listData;
  }

  Future<void> updateTodo(TodoModel entity) async {
    final listTodo = await getListTodo();

    final elementIndex =
    listTodo.indexWhere((element) => element.id == entity.id);

    listTodo[elementIndex] = entity;

    await saveNewList(listTodo);
  }

  deleteTodos(List<TodoModel> data, String boxName) async {
    for (var element in data) {
      await deleteTodo(element, boxName);
    }
  }

  deleteTodo(TodoModel  entity, String boxName) async {
    final box = await Hive.openBox(boxName);

    final json = TodoModel.fromEntity(entity).toJson();

    final dataList = List.from(box.values);

    final itemIndex = dataList.indexWhere((element) {
      print(element.toString() == json.toString());
      return element.toString() == json.toString();
    });

    await box.deleteAt(itemIndex);
  }

  deleteDataFromBox(String boxName) async {
    final box = await Hive.openBox(boxName);

    await box.deleteFromDisk();
  }

  deleteAll() async {
    final boxTodo = await Hive.openBox(StorageBoxes.todos);
    final boxCompletedTodo = await Hive.openBox(StorageBoxes.completedTodos);

    await boxTodo.deleteFromDisk();
    await boxCompletedTodo.deleteFromDisk();
  }
}

