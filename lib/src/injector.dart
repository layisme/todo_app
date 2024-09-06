part of '../main.dart';

final injector = GetIt.instance;

Future<void> init() async {
  //* Local Database
  injector
    //   ..registerLazySingleton<LocalDatabase>(
    //     () => LocalDatabase(),
    //   )
    // ..registerLazySingleton<>(() => )

    //* Datasources
    ..registerLazySingleton<TaskRemoteDatasource>(
      () => TaskRemoteDatasourceImpl(),
    )

    //* Repositories
    ..registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(injector()),
    )

    //* Usecases
    ..registerLazySingleton<TaskUsecase>(
      () => TaskUsecase(injector()),
    )

    //* Cubit
    ..registerFactory<GetTaskListingCubit>(
      () => injector<GetTaskListingCubit>(),
    )
    ..registerFactory<CreateTaskCubit>(
      () => injector<CreateTaskCubit>(),
    )
    ;
}
