part of 'create_task_cubit.dart';

sealed class CreateTaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CreateTaskStateInitial extends CreateTaskState {}

final class CreateTaskStateLoading extends CreateTaskState {}

final class CreateTaskStateSuccess extends CreateTaskState {}

final class CreateTaskStateError extends CreateTaskState {
  final String? message;
  CreateTaskStateError(this.message);

  @override
  List<Object?> get props => [message];
}
