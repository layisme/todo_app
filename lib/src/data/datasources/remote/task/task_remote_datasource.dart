import 'package:todo_app/src/data/enum/export_enums.dart';
import 'package:todo_app/src/domain/entities/export_entities.dart';

abstract class TaskRemoteDatasource {
  Future<TaskListingEntity?> listings({TaskStatus? status});
  Future<void> create(TaskEntity task);
  Future<void> update(TaskEntity task);
  Future<void> remove(String id);
  Future<void> markAsCompleted(String id);
}
