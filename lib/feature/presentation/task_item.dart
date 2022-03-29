import 'package:flutter/material.dart';
import 'package:myalarm/feature/data/model/task_model.dart';

class TaskItem extends StatelessWidget {
  final TaskModel taskModel;

  const TaskItem({Key? key, required this.taskModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                '${taskModel.title}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                width: 12,
              ),
              Text(
                  '${TimeOfDay.fromDateTime(DateTime.parse(taskModel.startTime!)).format(context)} - ${TimeOfDay.fromDateTime(DateTime.parse(taskModel.endTime!)).format(context)}',
                  style: const TextStyle(fontSize: 12))
            ],
          ),
        ),
      ),
    );
  }
}
