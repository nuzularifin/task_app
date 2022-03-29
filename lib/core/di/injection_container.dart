import 'package:get_it/get_it.dart';
import 'package:myalarm/feature/data/datasource/task_local_datasource.dart';
import 'package:myalarm/feature/data/repository/task_repositroy_impl.dart';
import 'package:myalarm/feature/domain/repository/task_repository.dart';
import 'package:myalarm/feature/domain/usecases/get_all_task_usecase.dart';
import 'package:myalarm/feature/domain/usecases/save_task_usecase.dart';
import 'package:myalarm/feature/domain/usecases/stream_time_scheduler.dart';
import 'package:myalarm/feature/presentation/bloc/task_schedule_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => TaskScheduleBloc(
      getAllTaskUseCase: sl(),
      saveTaskUseCase: sl(),
      streamTimeScheduler: sl()));

  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));

  sl.registerLazySingleton<TaskLocalDataSource>(
      () => TaskLocalDataSourceImpl());

  sl.registerLazySingleton(() => StreamTimeScheduler(sl()));

  sl.registerLazySingleton(() => GetAllTaskUseCase(taskRepository: sl()));
  sl.registerLazySingleton(() => SaveTaskUseCase(taskRepository: sl()));
}
