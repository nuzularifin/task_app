import 'package:equatable/equatable.dart';
import 'package:myalarm/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:myalarm/core/usecases/usecase.dart';
import 'package:myalarm/feature/domain/entities/task_entity.dart';
import 'package:myalarm/feature/domain/repository/task_repository.dart';

class SaveTaskUseCase extends UseCase<void, SaveTaskParams> {
  final TaskRepository taskRepository;

  SaveTaskUseCase({required this.taskRepository});

  @override
  Future<Either<Failure, void>> call(SaveTaskParams params) async {
    return await taskRepository.saveTask(params.taskEntity);
  }
}

class SaveTaskParams extends Equatable {
  final TaskEntity taskEntity;

  const SaveTaskParams(this.taskEntity);

  @override
  List<Object?> get props => [taskEntity];
}
