import 'package:clean_arch_example/features/main/presentation/cubits/delete_todo/delete_todo_cubit.dart';
import 'package:clean_arch_example/features/main/presentation/cubits/save_todo/save_todo_cubit.dart';
import 'package:clean_arch_example/features/main/presentation/cubits/todo/todo_cubit.dart';
import 'package:clean_arch_example/features/main/presentation/screens/home_screen.dart';
import 'package:clean_arch_example/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {

  late TodoCubit todoCubit;
  late SaveTodoCubit saveTodoCubit;
  late DeleteTodoCubit deleteTodoCubit;

  @override
  void initState() {
    saveTodoCubit = locator();
     todoCubit = locator();
     deleteTodoCubit = locator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: todoCubit),
        BlocProvider.value(value: saveTodoCubit),
        BlocProvider.value(value: deleteTodoCubit)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
