import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myalarm/feature/data/model/task_model.dart';
import 'package:myalarm/feature/presentation/bloc/task_schedule_bloc.dart';
import 'package:myalarm/feature/presentation/clock_painter.dart';

class ClockView extends StatefulWidget {
  final List<TaskModel> taskList;
  const ClockView({Key? key, required this.taskList}) : super(key: key);

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: BlocProvider.of<TaskScheduleBloc>(context).onStreamSchedule(),
        builder: (context, snapshot) {
          // print("Snapshot Data ========== ${snapshot.data}");
          return SizedBox(
            height: 300,
            width: 300,
            child: Transform.rotate(
              angle: -pi / 2,
              child: CustomPaint(
                painter: ClockPainter(
                    DateTime.fromMillisecondsSinceEpoch(
                        snapshot.data ?? DateTime.now().millisecondsSinceEpoch),
                    widget.taskList),
              ),
            ),
          );
        });
  }
}
