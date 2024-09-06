import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/core/extensions/extension_method.dart';
import 'package:todo_app/src/core/style/style.dart';
import 'package:todo_app/src/domain/entities/export_entities.dart';
import 'package:todo_app/src/presentation/_widget/button/button_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/presentation/_widget/date_time/date_time_widget.dart';
import 'package:todo_app/src/presentation/_widget/dialog/popup_dialog.dart';
import 'package:todo_app/src/presentation/_widget/loading/popup/loading_popup.dart';
import 'package:todo_app/src/presentation/cubit/export_cubits.dart';
import 'package:intl/intl.dart' as intl;

class AddTaskScreen extends StatefulWidget {
  final TaskEntity? task;
  const AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool isShowTimePicker = false;
  DateTime selectedTime = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void submitData() {
    if (_formKey.currentState!.validate()) {
      timeController.text = intl.DateFormat.jm().format(selectedTime);
      if (widget.task != null) {
        context.read<CreateTaskCubit>().update(TaskEntity(
            id: widget.task?.id,
            name: titleController.text.trim(),
            description: descriptionController.text,
            date: selectedDate.toIso8601String(),
            time: timeController.text,
            isComplete: widget.task?.isComplete));
      } else {
        context.read<CreateTaskCubit>().create(TaskEntity(
            name: titleController.text,
            description: descriptionController.text,
            date: selectedDate.toIso8601String(),
            time: timeController.text,
            isComplete: false));
      }
    }
  }

  @override
  void initState() {
    titleController.text = widget.task?.name ?? '';
    descriptionController.text = widget.task?.description ?? '';
    dateController.text =
        DateTime.tryParse(widget.task?.date ?? '')?.toSlashDDMMYY() ?? '';
    timeController.text = widget.task?.time ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateTaskCubit, CreateTaskState>(
      listener: (context, state) {
        if (state is CreateTaskStateLoading) {
          LoadingPopup.showLoading(context);
        }
        if (state is CreateTaskStateSuccess) {
          for (int i = 0; i < 2; i++) {
            Navigator.of(context, rootNavigator: true).pop();
          }
        }
        if (state is CreateTaskStateError) {
          for (int i = 0; i < 2; i++) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          PopupDialog.showFailed(context, content: state.message);
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: const CupertinoNavigationBar(
            middle: Text(
              'Add New Task',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(text: TextSpan(
                            text: 'Title Task',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: ' *',
                                style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.red.shade700),
                              )
                            ]
                          )),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: titleController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Task Title!';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (value) {
                              submitData();
                            },
                            decoration: const InputDecoration(
                                hintText: 'Add Task Name...'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Description',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            minLines: 3,
                            maxLines: 6,
                            controller: descriptionController,
                            decoration: const InputDecoration(
                                hintText: 'Add Description...'),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  onTap: showDatePicker,
                                  controller: dateController,
                                  decoration: const InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.calendar_month_rounded),
                                      hintText: 'dd/mm/yy'),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  onTap: showTimePicker,
                                  controller: timeController,
                                  decoration: const InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.access_time_rounded),
                                      hintText: 'hh : mm'),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ButtonWidget.border(
                        borderColor: Style.primaryButton,
                        title: 'Cancel',
                        titleColor: Style.primaryButton,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: ButtonWidget(
                      onPressed: submitData,
                      title: 'Create',
                      titleColor: Colors.white,
                      backgroundColor: Style.primaryButton,
                    ))
                  ],
                ),
                const SafeArea(child: SizedBox())
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDatePicker() {
    isShowTimePicker = false;
    showCupertinoModalPopup(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          child: isShowTimePicker
              ? timePickerWidget()
              : Container(
                  color: Colors.white,
                  height: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          isShowTimePicker = true;
                          dateController.text = selectedDate.toSlashDDMMYY();
                          setState(() {});
                          state(() {});
                        },
                        child: const Text('Next'),
                      ),
                      Expanded(
                        child: DateTimeWidget(
                          onSelectedItemChanged: (value) {
                            selectedDate = value;
                            state(() {});
                          },
                          // minDate: DateTime.now(),
                          // maxDate: DateTime.now(),
                          selectedDate: selectedDate,
                          mode: PickerMode.monthDay,
                        ),
                      ),
                    ],
                  ),
                ),
        );
      }),
    );
  }

  void showTimePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => timePickerWidget(),
    );
  }

  Widget timePickerWidget() {
    return Container(
      height: 250,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton.icon(
            onPressed: () {
              timeController.text = intl.DateFormat.jm().format(selectedTime);
              Navigator.pop(context);
              setState(() {});
            },
            label: const Text('Done'),
            icon: const Icon(Icons.check),
          ),
          Expanded(
            child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: selectedTime,
                onDateTimeChanged: (value) {
                  selectedTime = value;
                  setState(() {});
                }),
          ),
        ],
      ),
    );
  }
}
