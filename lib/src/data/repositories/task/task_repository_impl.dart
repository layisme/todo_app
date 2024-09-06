import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todo_app/src/data/datasources/export_datasources.dart';
import 'package:todo_app/src/data/enum/export_enums.dart';
import 'package:todo_app/src/domain/entities/task/task_entity.dart';
import 'package:todo_app/src/domain/entities/task_listing/task_listing_entity.dart';
import 'package:todo_app/src/domain/repositories/export_repositories.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDatasource _datasource;
  TaskRepositoryImpl(this._datasource);
  @override
  Future<Either<FirebaseException, TaskListingEntity?>> listings(
      {TaskStatus? status}) async {
    try {
      final response = await _datasource.listings(status: status);
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<FirebaseException, void>> create(TaskEntity task) async {
    try {
      final result = await _datasource.create(task);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<FirebaseException, void>> markAsCompleted(String id) async {
    try {
      final result = await _datasource.markAsCompleted(id);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }
  
  @override
  Future<Either<FirebaseException, void>> update(TaskEntity task) async {
    try {
      final result = await _datasource.update(task);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }
  
  @override
  Future<Either<FirebaseException, void>> remove(String id) async {
    try {
      final result = await _datasource.remove(id);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(e);
    }
  }
}
