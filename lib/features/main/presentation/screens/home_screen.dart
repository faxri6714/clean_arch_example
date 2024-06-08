import 'package:clean_arch_example/core/utils/todo_storage_service.dart';
import 'package:clean_arch_example/features/main/presentation/cubits/delete_todo/delete_todo_cubit.dart';
import 'package:clean_arch_example/features/main/presentation/cubits/todo/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/error_flash_bar.dart';
import '../../../../core/utils/success_flush_bar.dart';
import '../widgets/text_field_widget.dart';
import '../widgets/todo_card_widget.dart';
import 'create_todo_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controllerSearch = TextEditingController();


  @override
  void initState() {
    BlocProvider.of<TodoCubit>(context).load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateTodoScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
          // IconButton(
          //   onPressed: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const CompletedTodosScreen(),
          //       ),
          //     );
          //   },
          //   icon: const Icon(Icons.done, color: Colors.white),
          // ),
        ],
        title: const Text(
          'Todo list',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocListener<DeleteTodoCubit, DeleteTodoState>(
        listener: (context, state) {
          if(state is DeleteTodoError){
            ErrorFlushBar(state.message).show(context);
          }
          if(state is DeleteTodoSuccess){
            SuccessFlushBar("Todo успешно удолено ${state.entity.title}").show(context);
            BlocProvider.of<TodoCubit>(context).remove(state.entity);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextFormFieldWidget(
                controller: controllerSearch,
                onChange: (search) async {
                 BlocProvider.of<TodoCubit>(context).search(search);

                },
                hintText: "Search",
              ),
              const SizedBox(height: 10),
              BlocBuilder<TodoCubit, TodoState>(
                builder: (context, state) {
                  if (state is TodoLoading) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  }
                  if (state is TodoError) {
                    return Expanded(child: Center(child: Text(state.message),));
                  }
                  if (state is TodoLoaded) {
                    final listTodo = state.listTodo;

                  }
                  final listTodo = BlocProvider.of<TodoCubit>(context,listen: true).listTodo;
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        BlocProvider.of<TodoCubit>(context).load();
                      },
                      child: ListView.separated(
                        itemCount: listTodo.length,
                        itemBuilder: (context, index) {
                          final todo = listTodo[index];

                          return TodoCardWidget(
                            entity: todo,
                            onDone: () async {
                              // context
                              //     .read<CompletedTodoProvider>()
                              //     .marcTodoCompletetd(todo);
                              // context.read<TodoProvider>().remove(todo);
                            },


                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 10),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
