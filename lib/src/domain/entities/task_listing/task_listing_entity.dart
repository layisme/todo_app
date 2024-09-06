import 'package:equatable/equatable.dart';
import 'package:todo_app/src/domain/entities/export_entities.dart';

class TaskListingEntity extends Equatable {
  final List<TaskEntity>? tasks;

  const TaskListingEntity({this.tasks});

  @override
  List<Object?> get props => [tasks];
}
