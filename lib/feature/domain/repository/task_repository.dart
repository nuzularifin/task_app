import 'package:dartz/dartz.dart';
import 'package:myalarm/core/error/failure.dart';
import 'package:myalarm/feature/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Stream<Either<Failure, int>> streamTime(int id);
  Future<Either<Failure, List<TaskEntity>>> getAllTask();
  Future<Either<Failure, void>> saveTask(TaskEntity taskEntity);
}
