import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myalarm/core/error/failure.dart';
import 'package:myalarm/core/usecases/usecase.dart';
import 'package:myalarm/feature/domain/repository/task_repository.dart';

class StreamTimeScheduler
    extends StreamUseCase<int, StreamTimeSchedulerParams> {
  final TaskRepository repository;

  StreamTimeScheduler(this.repository);

  @override
  Stream<Either<Failure, int>> stream(StreamTimeSchedulerParams params) async* {
    yield* repository.streamTime(params.id);
  }
}

class StreamTimeSchedulerParams extends Equatable {
  final int id;

  const StreamTimeSchedulerParams({required this.id});

  @override
  List<Object?> get props => [id];
}
