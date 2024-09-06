import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/core/style/style.dart';
import 'package:todo_app/src/data/enum/export_enums.dart';
import 'package:todo_app/src/presentation/_widget/dialog/popup_dialog.dart';
import 'package:todo_app/src/presentation/_widget/loading/base_loading_widget.dart';
import 'package:todo_app/src/presentation/_widget/loading/popup/loading_popup.dart';
import 'package:todo_app/src/presentation/_widget/task_card/task_card_widget.dart';
import 'package:todo_app/src/presentation/cubit/export_cubits.dart';
import 'package:todo_app/src/presentation/screens/add_task/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TaskStatus? status;
    List<TaskStatus> statuses = [
      TaskStatus.all,
      TaskStatus.complete,
      TaskStatus.inComplete
    ];
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.account_circle_outlined,
          color: Colors.white,
        ),
        title: const Text('Welcome, Guys'),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Style.primaryButton,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CreateTaskCubit, CreateTaskState>(
            listener: (context, state) {
              if (state is CreateTaskStateSuccess) {
                Navigator.pop(context);
                context.read<GetTaskListingCubit>().listings();
              }
              if (state is CreateTaskStateLoading) {
                LoadingPopup.showLoading(context);
              }
            },
          ),
          BlocListener<ChangeTaskCubit, ChangeTaskState>(
            listener: (context, state) {
              if (state is ChangeTaskStateLoaded) {
                context
                    .read<GetTaskListingCubit>()
                    .listings(status: state.status);
              }
            },
          ),
        ],
        child: ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: BlocBuilder<ChangeTaskCubit, ChangeTaskState>(
                      builder: (context, state) {
                        return Text(
                          (state is ChangeTaskStateLoaded) ? '${state.status.display!} Tasks' : '',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                  PopupMenuButton<TaskStatus>(
                    position: PopupMenuPosition.under,
                    padding: EdgeInsets.zero,
                    initialValue: status,
                    onSelected: context.read<ChangeTaskCubit>().onChanged,
                    itemBuilder: (context) => [
                      ...statuses.map((e) => PopupMenuItem(
                            value: e,
                            child: Text(e.display ?? ''),
                          )),
                    ],
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      color: Style.primaryButton,
                    ),
                  )
                ],
              ),
            ),
            BlocBuilder<GetTaskListingCubit, GetTaskListingState>(
              builder: (context, state) {
                if (state is GetTaskListingStateLoaded &&
                    state.data != null &&
                    state.data!.tasks!.isNotEmpty) {
                  return ListView(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    children: [
                      ...state.data!.tasks!.map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TaskCardWidget(task: e),
                          ))
                    ],
                  );
                }
                if (state is GetTaskListingStateError ||
                    (state is GetTaskListingStateLoaded &&
                        (state.data == null || state.data!.tasks!.isEmpty))) {
                  return Container(
                      height: 250,
                      alignment: Alignment.center,
                      child: PopupDialog.noResult());
                }
                return Container(
                    alignment: Alignment.center,
                    height: 250,
                    child: const BaseLoading());
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTaskScreen(),
                ));
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Create New'),
            ],
          ),
        ),
      ),
    );
  }
}
