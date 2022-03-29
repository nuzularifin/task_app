import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myalarm/core/utils/core_function.dart';
import 'package:myalarm/feature/presentation/bloc/task_schedule_bloc.dart';

class InputTaskScreen extends StatefulWidget {
  const InputTaskScreen({Key? key}) : super(key: key);

  @override
  State<InputTaskScreen> createState() => _InputTaskScreenState();
}

class _InputTaskScreenState extends State<InputTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _fromTimeController = TextEditingController();
  final TextEditingController _toTimeController = TextEditingController();

  DateTime? selectedDateTime;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  @override
  Widget build(BuildContext ctxInput) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Task'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<TaskScheduleBloc, TaskScheduleState>(
        listener: (context, state) {
          if (state is TaskDateState) {
            _dateController.text =
                CoreFunction().showDateName(state.selectedDate);
            selectedDateTime = state.selectedDate;
          } else if (state is TaskFromTimeState) {
            _fromTimeController.text = state.timeOfDay.format(context);
            selectedStartTime = state.timeOfDay;
          } else if (state is TaskToTimeState) {
            _toTimeController.text = state.timeOfDay.format(context);
            selectedEndTime = state.timeOfDay;
          } else if (state is SaveTaskSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Title', border: OutlineInputBorder()),
                      controller: _titleController,
                      validator: (value) =>
                          value!.isEmpty ? 'Task title cannot be blank' : null,
                      // onSaved: (value) => _email = value,,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      onTap: () => openCalender(context),
                      readOnly: true,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () => openCalender(context),
                              icon: const Icon(Icons.calendar_today)),
                          labelText: 'Date',
                          border: const OutlineInputBorder()),
                      controller: _dateController,
                      validator: (value) =>
                          value!.isEmpty ? 'Date cannot be blank' : null,
                      // onSaved: (value) => _email = value,,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      onTap: () => openFromTimePicker(context),
                      readOnly: true,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () => openFromTimePicker(context),
                              icon: const Icon(Icons.calendar_today)),
                          labelText: 'From (time)',
                          border: const OutlineInputBorder()),
                      controller: _fromTimeController,
                      validator: (value) =>
                          value!.isEmpty ? 'Start time cannot be blank' : null,
                      // onSaved: (value) => _email = value,,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      onTap: () => openToTimePicker(context),
                      readOnly: true,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () => openToTimePicker(context),
                              icon: const Icon(Icons.calendar_today)),
                          labelText: 'To (time)',
                          border: const OutlineInputBorder()),
                      controller: _toTimeController,
                      validator: (value) =>
                          value!.isEmpty ? 'End time cannot be blank' : null,
                      // onSaved: (value) => _email = value,,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    state is TaskScheduleLoading
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                                child: CircularProgressIndicator()),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    print('validate');
                                  } else {
                                    print('unvalidate');
                                    return;
                                  }

                                  String title = _titleController.text;
                                  String dateTime = selectedDateTime.toString();
                                  DateTime startTime = DateTime(
                                      selectedDateTime!.year,
                                      selectedDateTime!.month,
                                      selectedDateTime!.day,
                                      selectedStartTime!.hour,
                                      selectedStartTime!.minute);
                                  DateTime endTime = DateTime(
                                      selectedDateTime!.year,
                                      selectedDateTime!.month,
                                      selectedDateTime!.day,
                                      selectedEndTime!.hour,
                                      selectedEndTime!.minute);

                                  saveTask(context, title, dateTime,
                                      startTime.toString(), endTime.toString());
                                },
                                child: const Text('Save')))
                  ]),
            ),
          );
        },
      ),
    );
  }

  openCalender(BuildContext context) {
    BlocProvider.of<TaskScheduleBloc>(context)
        .add(TaskScheduleDateEvent(context));
  }

  openFromTimePicker(BuildContext context) {
    BlocProvider.of<TaskScheduleBloc>(context)
        .add(TaskScheduleFromTimeEvent(context: context));
  }

  openToTimePicker(BuildContext context) {
    BlocProvider.of<TaskScheduleBloc>(context)
        .add(TaskScheduleToTimeEvent(context: context));
  }

  Widget showTextTitle(String title) {
    return Text(title);
  }

  saveTask(BuildContext context, String title, String dateTime,
      String startTime, String endTime) {
    BlocProvider.of<TaskScheduleBloc>(context).add(SaveTaskScheduleEvent(
        dateTime: dateTime,
        endTime: endTime,
        startTime: startTime,
        title: title));
  }
}
