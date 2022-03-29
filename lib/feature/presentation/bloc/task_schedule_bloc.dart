import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myalarm/core/error/failure.dart';
import 'package:myalarm/core/usecases/usecase.dart';
import 'package:myalarm/feature/data/model/task_model.dart';
import 'package:myalarm/feature/domain/entities/task_entity.dart';
import 'package:myalarm/feature/domain/usecases/get_all_task_usecase.dart';
import 'package:myalarm/feature/domain/usecases/save_task_usecase.dart';
import 'package:myalarm/feature/domain/usecases/stream_time_scheduler.dart';

part 'task_schedule_event.dart';
part 'task_schedule_state.dart';

class TaskScheduleBloc extends Bloc<TaskScheduleEvent, TaskScheduleState> {
  StreamTimeScheduler streamTimeScheduler;
  GetAllTaskUseCase getAllTaskUseCase;
  SaveTaskUseCase saveTaskUseCase;

  TaskScheduleBloc(
      {required this.streamTimeScheduler,
      required this.getAllTaskUseCase,
      required this.saveTaskUseCase})
      : super(TaskScheduleInitial()) {
    on<TaskScheduleEvent>((event, emit) {});

    on<GetAllTaskEvent>((event, emit) async {
      emit(GetAllTaskLoading());

      final result = await getAllTaskUseCase(NoParams());

      result.fold((failure) {
        emit(GetAllTaskEmpty());
      }, (success) {
        List<TaskModel> taskList = [];
        for (final data in success) {
          taskList.add(TaskModel(
              id: data.id,
              title: data.title,
              dateTime: data.dateTime,
              startTime: data.startTime,
              endTime: data.endTime));
        }
        emit(GetAllTaskLoaded(taskList: taskList));
      });
    });

    on<SaveTaskScheduleEvent>((event, emit) async {
      emit(TaskScheduleLoading());

      TaskEntity task = TaskEntity(
          dateTime: event.dateTime,
          startTime: event.startTime,
          title: event.title,
          endTime: event.endTime);

      await saveTaskUseCase.taskRepository.saveTask(task).then((value) {
        value.fold((failure) {
          emit(SaveTaskFailed());
        }, (success) {
          emit(SaveTaskSuccess());
        });
      });
    });

    on<TaskScheduleDateEvent>((event, emit) async {
      await showDatePicker(
              context: event.context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2022),
              lastDate: DateTime(2023))
          .then((value) {
        if (value != null) {
          emit(TaskDateState(value));
        }
      });
    });

    on<TaskScheduleFromTimeEvent>((event, emit) async {
      await showTimePicker(context: event.context, initialTime: TimeOfDay.now())
          .then((value) {
        if (value != null) {
          emit(TaskFromTimeState(timeOfDay: value));
        }
      });
    });

    on<TaskScheduleToTimeEvent>((event, main) async {
      await showTimePicker(context: event.context, initialTime: TimeOfDay.now())
          .then((value) {
        if (value != null) {
          emit(TaskToTimeState(timeOfDay: value));
        }
      });
    });
  }

  Stream<int> onStreamSchedule() async* {
    StreamTransformer<Either<Failure, int>, int> transformer =
        StreamTransformer.fromHandlers(
            handleData: (Either<Failure, int> data, EventSink<int> output) {
      if (data.isRight()) {
        output.add(data.getOrElse(() => -1));
      }
    });

    yield* streamTimeScheduler
        .stream(const StreamTimeSchedulerParams(id: 0))
        .transform(transformer);
  }
}
