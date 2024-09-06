import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todo_app/src/data/enum/export_enums.dart';
import 'package:todo_app/src/domain/entities/export_entities.dart';

abstract class TaskRepository {
  Future<Either<FirebaseException, TaskListingEntity?>> listings(
      {TaskStatus? status});
  Future<Either<FirebaseException, void>> create(TaskEntity task);
  Future<Either<FirebaseException, void>> update(TaskEntity task);
  Future<Either<FirebaseException, void>> remove(String id);
  Future<Either<FirebaseException, void>> markAsCompleted(String id);
}
