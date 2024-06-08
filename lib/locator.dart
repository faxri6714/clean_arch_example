import 'package:clean_arch_example/core/utils/todo_storage_service.dart';
import 'package:clean_arch_example/features/main/data/datasources/main_local_data_sourse.dart';
import 'package:clean_arch_example/features/main/data/repositirys/main_repository_impl.dart';
import 'package:clean_arch_example/features/main/domain/usecases/todo_usecasses.dart';
import 'package:clean_arch_example/features/main/presentation/cubits/save_todo/save_todo_cubit.dart';
import 'package:clean_arch_example/features/main/presentation/cubits/todo/todo_cubit.dart';
import 'package:get_it/get_it.dart';

import 'features/main/domain/repositorys/main_repository.dart';
import 'features/main/presentation/cubits/delete_todo/delete_todo_cubit.dart';

final locator = GetIt.I;

setup() {
  locator.registerLazySingleton<MainRepository>(
      () => MainRepositoryImpl(locator()));
  locator.registerLazySingleton<MainLocalDataSource>(
    () => MainLocalDataSourceImpl(
      locator()
    )
  );
  locator.registerLazySingleton(() => TodoStorageService());
  locator.registerLazySingleton(() => GetListTodoUsecase( repository: locator()));
  locator.registerLazySingleton(() => DeleteTodoUsecase(locator()));
  locator.registerLazySingleton(() => SaveTodoUsecase(locator()));

  locator.registerFactory(() => TodoCubit(locator()));
  locator.registerFactory(() => SaveTodoCubit(locator()));
  locator.registerFactory(() => DeleteTodoCubit(locator()));
}
