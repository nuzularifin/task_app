part of 'task_schedule_bloc.dart';

abstract class TaskScheduleState extends Equatable {
  const TaskScheduleState();

  @override
  List<Object> get props => [];
}

class TaskScheduleInitial extends TaskScheduleState {}

class TaskScheduleLoading extends TaskScheduleState {}

class SaveTaskSuccess extends TaskScheduleState {}

class SaveTaskFailed extends TaskScheduleState {}

class GetAllTaskLoading extends TaskScheduleState {}

class GetAllTaskEmpty extends TaskScheduleState {}

class GetAllTaskLoaded extends TaskScheduleState {
  final List<TaskModel> taskList;

  const GetAllTaskLoaded({required this.taskList});

  @override
  List<Object> get props => [taskList];
}

class TaskSecheduleStream extends TaskScheduleState {}

class TaskDateState extends TaskScheduleState {
  final DateTime selectedDate;

  const TaskDateState(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}

class TaskFromTimeState extends TaskScheduleState {
  final TimeOfDay timeOfDay;

  const TaskFromTimeState({required this.timeOfDay});

  @override
  List<Object> get props => [timeOfDay];
}

class TaskToTimeState extends TaskScheduleState {
  final TimeOfDay timeOfDay;

  const TaskToTimeState({required this.timeOfDay});

  @override
  List<Object> get props => [timeOfDay];
}

class SaveTaskState extends TaskScheduleState {}
