part of 'get_task_listing_cubit.dart';

sealed class GetTaskListingState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetTaskListingStateInitial extends GetTaskListingState {}

final class GetTaskListingStateLoading extends GetTaskListingState {}

final class GetTaskListingStateLoaded extends GetTaskListingState {
  final TaskListingEntity? data;

  GetTaskListingStateLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

final class GetTaskListingStateError extends GetTaskListingState {
  final String? message;
  GetTaskListingStateError(this.message);

  @override
  List<Object?> get props => [message];
}
