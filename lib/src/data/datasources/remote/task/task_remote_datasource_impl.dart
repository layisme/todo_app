import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/src/data/datasources/export_datasources.dart';
import 'package:todo_app/src/data/enum/export_enums.dart';
import 'package:todo_app/src/data/models/export_models.dart';
import 'package:todo_app/src/domain/entities/export_entities.dart';

class TaskRemoteDatasourceImpl implements TaskRemoteDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final tasksCollection = FirebaseFirestore.instance.collection('tasks');

  @override
  Future<TaskListingEntity?> listings({TaskStatus? status}) async {
    try {
      final dt = tasksCollection
          .where('isComplete', isEqualTo: status?.value)
          .orderBy('isComplete', descending: false);
      QuerySnapshot querySnapshot = await dt.get();
      List<TaskModel> tasks = querySnapshot.docs.map((doc) {
        TaskModel task = TaskModel.fromJson(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id);
        return task;
      }).toList();
      TaskListingModel taskListingModel = TaskListingModel(tasks: tasks);
      return taskListingModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> create(TaskEntity task) async {
    try {
      final FirebaseFirestore instance = FirebaseFirestore.instance;
      await instance.runTransaction((transaction) async {
        QuerySnapshot querySnapshot = await tasksCollection
            .where('name', isEqualTo: task.name)
            .limit(1)
            .get();
        if (querySnapshot.docs.isEmpty) {
          transaction.set(
              tasksCollection.doc(), TaskModel().fromEntity(task).toJson());
        } else {
          throw FirebaseException(
              plugin: 'ios',
              message: 'Task Title (${task.name}) is already exist!');
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(TaskEntity task) async {
    tasksCollection.doc(task.id).update(TaskModel().fromEntity(task).toJson());
  }

  @override
  Future<void> markAsCompleted(String id) async {
    tasksCollection.doc(id).update({'isComplete': true});
  }

  @override
  Future<void> remove(String id) async {
    tasksCollection.doc(id).delete();
  }
}
