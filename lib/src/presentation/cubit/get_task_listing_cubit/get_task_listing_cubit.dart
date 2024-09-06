import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/data/enum/export_enums.dart';
import 'package:todo_app/src/domain/entities/task_listing/task_listing_entity.dart';
import 'package:todo_app/src/domain/usecases/export_usecases.dart';

part 'get_task_listing_state.dart';

class GetTaskListingCubit extends Cubit<GetTaskListingState> {
  GetTaskListingCubit(this._usecase) : super(GetTaskListingStateInitial());

  Future<void> listings({TaskStatus? status}) async {
    final result = await _usecase.listings(status: status);
    result.fold(
      (error) => emit(GetTaskListingStateError(error.message)),
      (data) => emit(GetTaskListingStateLoaded(data)),
    );
  }

  final TaskUsecase _usecase;
}
