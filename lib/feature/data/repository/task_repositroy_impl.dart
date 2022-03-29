import 'dart:async';

import 'package:myalarm/core/error/exception.dart';
import 'package:myalarm/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:myalarm/feature/data/datasource/task_local_datasource.dart';
import 'package:myalarm/feature/domain/entities/task_entity.dart';
import 'package:myalarm/feature/domain/repository/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Stream<Either<Failure, int>> streamTime(int id) async* {
    StreamTransformer<int, Either<Failure, int>> transformer =
        StreamTransformer.fromHandlers(
            handleData: (int data, EventSink<Either<Failure, int>> output) {
      output.add(Right(data));
    });

    yield* localDataSource.streamTime(id).transform(transformer);
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTask() async {
    try {
      return Right(await localDataSource.getAllTask());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveTask(TaskEntity taskEntity) async {
    try {
      return Right(await localDataSource.saveTask(taskEntity));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    }
  }
}
