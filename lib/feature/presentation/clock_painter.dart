import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myalarm/feature/data/model/task_model.dart';

class ClockPainter extends CustomPainter {
  final DateTime dateTime;
  final List<TaskModel> taskList;
  ClockPainter(this.dateTime, this.taskList);

  // 60 sec = 360 degree, 1 sec - 6 deg

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    var fillbrush = Paint()..color = const Color(0xFF0000000);

    var outlineBrush = Paint()
      ..color = const Color(0xFF4095d6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    var centerBrush = Paint()..color = const Color(0xFFFFFFFF);

    var secHandBrush = Paint()
      ..color = const Color(0xFFF36522)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var minHandBrush = Paint()
      ..shader = const RadialGradient(colors: [Colors.lightBlue, Colors.pink])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    var hourHandBrush = Paint()
      ..shader = const RadialGradient(colors: [Colors.lightBlue, Colors.pink])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    var dashBrush = Paint()
      ..color = const Color(0xFFF36522)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius - 40, fillbrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);

    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var hourHandX = centerX +
        80 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        80 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    canvas.drawCircle(center, 16, centerBrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 15;

    for (double i = 0; i < 360; i += 90) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }

    for (double i = 0; i < 360; i += 45) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }

    // for (int a = 0; a < taskList.length; a++) {
    //   // 1 menit 60 detik ;
    //   final startTime = DateTime.parse(taskList[a].startTime!);
    //   final endTime = DateTime.parse(taskList[a].endTime!);

    //   Path path = Path();
    //   double degToRad(num deg) => deg * (pi / 180.0);

    //   final radiusStart = startTime.hour * 30;
    //   final radiusEnd = endTime.hour * 30;
    //   final diffRad = radiusEnd - radiusStart;
    //   print('hour start => $radiusStart,  hour end => $radiusEnd');

    //   path.arcTo(
    //       Rect.fromCenter(
    //           center: center, width:    size.width, height: size.height),
    //       degToRad(240),
    //       degToRad(270),
    //       true);

    //   canvas.drawPath(path, minHandBrush);
    // }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
