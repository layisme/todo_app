import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? date;
  final String? time;
  final bool? isComplete;

  const TaskEntity(
      {this.id,
      this.name,
      this.description,
      this.date,
      this.time,
      this.isComplete});

  TaskEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? date,
    String? time,
    bool? isComplete,
  }) =>
      TaskEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        date: date ?? this.date,
        time: time ?? this.time,
        isComplete: isComplete ?? this.isComplete,
      );

  @override
  List<Object?> get props =>
      [id, name, description, date, time, isComplete];
}
