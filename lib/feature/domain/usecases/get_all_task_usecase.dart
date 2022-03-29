import 'package:myalarm/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:myalarm/core/usecases/usecase.dart';
import 'package:myalarm/feature/domain/entities/task_entity.dart';
import 'package:myalarm/feature/domain/repository/task_repository.dart';

class GetAllTaskUseCase extends UseCase<List<TaskEntity>, NoParams> {
  final TaskRepository taskRepository;

  GetAllTaskUseCase({required this.taskRepository});

  @override
  Future<Either<Failure, List<TaskEntity>>> call(NoParams params) async {
    return await taskRepository.getAllTask();
  }
}
