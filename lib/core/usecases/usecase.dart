import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myalarm/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> stream(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
