part of 'change_task_cubit.dart';

sealed class ChangeTaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ChangeTaskStateInitial extends ChangeTaskState {}

final class ChangeTaskStateLoaded extends ChangeTaskState {
  final TaskStatus status;

  ChangeTaskStateLoaded(this.status);

  @override
  List<Object?> get props => [status];
}
