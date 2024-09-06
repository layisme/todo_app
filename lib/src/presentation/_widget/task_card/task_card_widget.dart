import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/core/extensions/extension_method.dart';
import 'package:todo_app/src/core/style/style.dart';
import 'package:todo_app/src/domain/entities/export_entities.dart';
import 'package:todo_app/src/presentation/_widget/dialog/popup_dialog.dart';
import 'package:todo_app/src/presentation/cubit/export_cubits.dart';
import 'package:todo_app/src/presentation/screens/add_task/add_task_screen.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskEntity task;
  const TaskCardWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: true,
      closeOnScroll: true,
      endActionPane: ActionPane(
          extentRatio: task.isComplete != null && task.isComplete! ? 0.5 : 0.9,
          motion: const DrawerMotion(),
          children: getActions(context)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        horizontalTitleGap: 0,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(
                  task: task,
                ),
              ));
        },
        style: ListTileStyle.drawer,
        tileColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Container(
          decoration: BoxDecoration(
              color: task.isComplete ?? false
                  ? Colors.green
                  : Colors.red.withOpacity(0.75),
              borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.name ?? '',
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87.withOpacity(0.65),
                                decorationColor: Colors.black54,
                                decoration: task.isComplete ?? false
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          SizedBox(
                            height: task.description == null ||
                                    task.description!.isEmpty
                                ? 0
                                : 6,
                          ),
                          task.description == null || task.description!.isEmpty
                              ? const SizedBox()
                              : Text(
                                  task.description ?? '',
                                  style: GoogleFonts.lato(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey),
                                ),
                        ],
                      ),
                    ),
                    task.isComplete ?? false
                        ? Container(
                            decoration: BoxDecoration(
                                color: Style.primaryButton,
                                shape: BoxShape.circle),
                            padding: const EdgeInsets.all(3.5),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 18,
                            ))
                        : const SizedBox()
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  '${task.date?.todm() ?? ''} ${task.time}',
                  style: GoogleFonts.lato(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black38),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<SlidableAction> getActions(BuildContext context) {
    List<SlidableAction> actions = [
      SlidableAction(
        onPressed: (_) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(
                  task: task,
                ),
              ));
        },
        label: 'Edit',
        icon: Icons.edit_outlined,
        backgroundColor: Style.primaryButton,
      ),
      SlidableAction(
        onPressed: (_) async {
          final res = await PopupDialog.yesNoPrompt(context, content: 'Are you sure to delete this Task?');
          if(res) {
            if (context.mounted) {
              context.read<CreateTaskCubit>().remove(task.id!);
            }
          }
        },
        label: 'Remove',
        icon: CupertinoIcons.delete,
        backgroundColor: Colors.red.shade700,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
    ];
    if (!(task.isComplete != null && task.isComplete!)) {
      actions.insert(
        0,
        SlidableAction(
          onPressed: (_) {
            context.read<CreateTaskCubit>().markAsCompleted(task.id!);
          },
          label: 'Mark as Complete',
          icon: Icons.check,
          backgroundColor: Colors.green,
          flex: 2,
        ),
      );
    }
    return actions;
  }
}
