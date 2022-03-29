import 'package:myalarm/feature/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel(
      {int? id,
      required String? title,
      required String? dateTime,
      required String? startTime,
      required String? endTime})
      : super(
            title: title,
            dateTime: dateTime,
            startTime: startTime,
            endTime: endTime);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        id: json['id'],
        title: json['title'],
        dateTime: json['dateTime'],
        startTime: json['startTime'],
        endTime: json['endTime']);
  }
}
