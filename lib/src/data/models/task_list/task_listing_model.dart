import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app/src/data/datasources/_mappers/entity_convertable.dart';
import 'package:todo_app/src/data/models/export_models.dart';
import 'package:todo_app/src/domain/entities/export_entities.dart';
part 'task_listing_model.g.dart';

@JsonSerializable()
class TaskListingModel
    with EntityConvertible<TaskListingModel, TaskListingEntity> {
  @JsonKey(name: 'items')
  final List<TaskModel>? tasks;

  TaskListingModel({this.tasks});
  factory TaskListingModel.fromJson(Map<String, dynamic> json) =>
      _$TaskListingModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskListingModelToJson(this);
  @override
  TaskListingEntity toEntity() =>
      TaskListingEntity(tasks: tasks?.map((e) => e.toEntity()).toList());
}
