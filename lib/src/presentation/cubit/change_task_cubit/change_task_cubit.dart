import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/data/enum/task_status/task_status.dart';

part 'change_task_state.dart';

class ChangeTaskCubit extends Cubit<ChangeTaskState> {
  ChangeTaskCubit() : super(ChangeTaskStateInitial()) {
    emit(ChangeTaskStateLoaded(TaskStatus.all));
  }

  void onChanged(TaskStatus status) => emit(ChangeTaskStateLoaded(status));
}
