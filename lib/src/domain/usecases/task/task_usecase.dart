import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todo_app/src/data/enum/export_enums.dart';
import 'package:todo_app/src/domain/entities/export_entities.dart';
import 'package:todo_app/src/domain/repositories/export_repositories.dart';

class TaskUsecase {
  final TaskRepository _repository;

  TaskUsecase(this._repository);

  Future<Either<FirebaseException, TaskListingEntity?>> listings(
          {TaskStatus? status}) =>
      _repository.listings(status: status);

  Future<Either<FirebaseException, void>> create(TaskEntity task) =>
      _repository.create(task);

  Future<Either<FirebaseException, void>> update(TaskEntity task) =>
      _repository.update(task);

  Future<Either<FirebaseException, void>> remove(String id) =>
      _repository.remove(id);

  Future<Either<FirebaseException, void>> markAsCompleted(String id) =>
      _repository.markAsCompleted(id);
}
