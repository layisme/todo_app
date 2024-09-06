// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskListingModel _$TaskListingModelFromJson(Map<String, dynamic> json) =>
    TaskListingModel(
      tasks: (json['items'] as List<dynamic>?)
          ?.map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskListingModelToJson(TaskListingModel instance) =>
    <String, dynamic>{
      'items': instance.tasks,
    };
