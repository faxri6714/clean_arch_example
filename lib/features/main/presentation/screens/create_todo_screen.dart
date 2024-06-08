

import 'package:clean_arch_example/core/utils/error_flash_bar.dart';
import 'package:clean_arch_example/core/utils/success_flush_bar.dart';
import 'package:clean_arch_example/features/main/presentation/cubits/save_todo/save_todo_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../domain/entites/todo_entity.dart';
import '../cubits/todo/todo_cubit.dart';
import '../widgets/text_field_widget.dart';


class CreateTodoScreen extends StatefulWidget {

  const CreateTodoScreen({Key? key}) : super(key: key);

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();

  TodoEntity entity = TodoEntity.empty();


  _clear(){
    entity = TodoEntity.empty();
    controllerTitle.clear();
    controllerDescription.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey.shade700,
        title: const Text(
          'Create Todo',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocListener<SaveTodoCubit, SaveTodoState>(
  listener: (context, state) {

   if(state is SaveTodoError){
     ErrorFlushBar(state.message).show(context);
   }
   if(state is SaveTodoSaved){
     SuccessFlushBar("Todo успешно добавлен").show(context);
     _clear();
     BlocProvider.of<TodoCubit>(context).load();
   }
  },

          child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextFormFieldWidget(
            controller: controllerTitle,
            hintText: "Title",
            onChange: (value) {
              value = value.toString().substring(0,1).toUpperCase() + value.toString().substring(1,value.toString().length).toLowerCase();

              entity = entity.copyWith(title: value);
            },
          ),
          const SizedBox(height: 20),
          TextFormFieldWidget(
            controller: controllerDescription,
            hintText: "Descriptions",
            onChange: (value) {
              value = value.toString().substring(0,1).toUpperCase() + value.toString().substring(1,value.toString().length).toLowerCase();

              entity = entity.copyWith(description: value);
            },
          ),
          const SizedBox(height: 30),
          BlocBuilder<SaveTodoCubit, SaveTodoState>(
  builder: (context, state) {
    return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: state is SaveTodoSaved? Colors.green :Colors.blueGrey,
              ),
              onPressed: ()   {
                BlocProvider.of<SaveTodoCubit>(context).save(entity);
              },
              child: const Text(
                "save",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          );
  },
)
        ],
      ),
    ),
),
    );
  }
}

