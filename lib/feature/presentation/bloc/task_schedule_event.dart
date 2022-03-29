part of 'task_schedule_bloc.dart';

abstract class TaskScheduleEvent extends Equatable {
  const TaskScheduleEvent();

  @override
  List<Object> get props => [];
}

class StreamTaskSchedule extends TaskScheduleEvent {}

class TaskScheduleDateEvent extends TaskScheduleEvent {
  final BuildContext context;

  const TaskScheduleDateEvent(this.context);
}

class GetAllTaskEvent extends TaskScheduleEvent {}

class TaskScheduleFromTimeEvent extends TaskScheduleEvent {
  final BuildContext context;

  const TaskScheduleFromTimeEvent({required this.context});
}

class TaskScheduleToTimeEvent extends TaskScheduleEvent {
  final BuildContext context;

  const TaskScheduleToTimeEvent({required this.context});
}

class SaveTaskScheduleEvent extends TaskScheduleEvent {
  final String title;
  final String dateTime;
  final String startTime;
  final String endTime;

  const SaveTaskScheduleEvent(
      {required this.title,
      required this.dateTime,
      required this.startTime,
      required this.endTime});

  @override
  List<Object> get props => [title, dateTime, startTime, endTime];
}
