import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  int? id;
  String? title;
  String? dateTime;
  String? startTime;
  String? endTime;

  TaskEntity(
      {required this.title,
      required this.dateTime,
      required this.startTime,
      required this.endTime});

  TaskEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    dateTime = json['dateTime'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['dateTime'] = dateTime;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    return data;
  }

  @override
  List<Object?> get props => [id, title, dateTime, startTime, endTime];
}
