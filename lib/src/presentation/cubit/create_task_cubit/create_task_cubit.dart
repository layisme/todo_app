import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/domain/entities/export_entities.dart';
import 'package:todo_app/src/domain/usecases/export_usecases.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit(this._usecase) : super(CreateTaskStateInitial());

  Future<void> create(TaskEntity task) async {
    emit(CreateTaskStateLoading());
    final result = await _usecase.create(task);
    result.fold((error) => emit(CreateTaskStateError(error.message)),
        (success) => emit(CreateTaskStateSuccess()));
  }

  Future<void> markAsCompleted(String id) async {
    emit(CreateTaskStateLoading());
    final result = await _usecase.markAsCompleted(id);
    result.fold((error) => emit(CreateTaskStateError(error.message)),
        (success) => emit(CreateTaskStateSuccess()));
  }

  Future<void> update(TaskEntity task) async {
    emit(CreateTaskStateLoading());
    final result = await _usecase.update(task);
    result.fold((error) => emit(CreateTaskStateError(error.message)),
        (success) => emit(CreateTaskStateSuccess()));
  }

  Future<void> remove(String id) async {
    emit(CreateTaskStateLoading());
    final result = await _usecase.remove(id);
    result.fold((error) => emit(CreateTaskStateError(error.message)),
        (success) => emit(CreateTaskStateSuccess()));
  }

  final TaskUsecase _usecase;
}
