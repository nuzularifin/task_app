import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myalarm/feature/data/model/task_model.dart';
import 'package:myalarm/feature/presentation/bloc/task_schedule_bloc.dart';
import 'package:myalarm/feature/presentation/task_item.dart';

import 'clock_view.dart';
import 'input_task_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<TaskModel> taskModel = [];

  @override
  void initState() {
    loadTaskData();
    super.initState();
  }

  loadTaskData() {
    BlocProvider.of<TaskScheduleBloc>(context).add(GetAllTaskEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return BlocProvider.value(
                value: BlocProvider.of<TaskScheduleBloc>(context),
                child: const InputTaskScreen(),
              );
            }));
          }),
      body: BlocConsumer<TaskScheduleBloc, TaskScheduleState>(
        listener: (context, state) {
          if (state is GetAllTaskLoaded) {
            taskModel = state.taskList;
          } else if (state is SaveTaskSuccess) {
            loadTaskData();
          }
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(12.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 150,
                ),
                ClockView(
                  taskList: taskModel,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Task List',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                state is GetAllTaskLoading
                    ? const SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Expanded(
                        child: taskModel.isEmpty
                            ? const Center(
                                child: Text('Empty Data'),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    taskModel.isNotEmpty ? taskModel.length : 0,
                                itemBuilder: (context, index) {
                                  return TaskItem(taskModel: taskModel[index]);
                                }),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
