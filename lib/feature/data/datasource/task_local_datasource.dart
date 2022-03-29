import 'dart:async';

import 'package:myalarm/core/db/task_helper.dart';
import 'package:myalarm/core/error/exception.dart';
import 'package:myalarm/feature/data/model/task_model.dart';
import 'package:myalarm/feature/domain/entities/task_entity.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getAllTask();
  Future<void> saveTask(TaskEntity taskEntity);

  Stream<int> streamTime(int id);
}

class TaskLocalDataSourceImpl extends TaskLocalDataSource {
  @override
  Future<List<TaskModel>> getAllTask() async {
    try {
      return TaskHelper.instance.selectAllData();
    } on Exception catch (e) {
      throw throwException(e);
    }
  }

  @override
  Future<void> saveTask(TaskEntity taskEntity) async {
    try {
      var task = TaskHelper.instance.insertTask(taskEntity);
      return task;
    } on Exception catch (e) {
      throw throwException(e);
    }
  }

  @override
  Stream<int> streamTime(int id) async* {
    try {
      yield* Stream.periodic(const Duration(seconds: 1), (int count) {
        return DateTime.now().millisecondsSinceEpoch + (count * 1000);
      });
    } on Exception catch (e) {
      throw throwException(e);
    }
  }
}

throwException(Exception e) {
  return DatabaseException(
      message: e.toString() == "" ? e.toString() : 'Database undefined');
}
