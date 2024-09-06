import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app/src/data/datasources/export_datasources.dart';
import 'package:todo_app/src/domain/entities/export_entities.dart';
part 'task_model.g.dart';

@JsonSerializable()
class TaskModel with EntityConvertible<TaskModel, TaskEntity> {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'time')
  final String? time;
  @JsonKey(name: 'isComplete')
  final bool? isComplete;

  TaskModel(
      {this.id,
      this.name,
      this.description,
      this.date,
      this.time,
      this.isComplete});

  TaskModel copyWith(
          {String? id,
          String? name,
          String? description,
          String? date,
          String? time,
          bool? isComplete}) =>
      TaskModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        date: date ?? this.date,
        time: time ?? this.time,
        isComplete: isComplete ?? this.isComplete
      );

  @override
  TaskEntity toEntity() => TaskEntity(
      id: id,
      name: name,
      description: description,
      date: date,
      time: time,
      isComplete: isComplete);

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  @override
  TaskModel fromEntity(TaskEntity model) => TaskModel(
      id: model.id,
      name: model.name,
      description: model.description,
      date: model.date,
      time: model.time,
      isComplete: model.isComplete);
}
