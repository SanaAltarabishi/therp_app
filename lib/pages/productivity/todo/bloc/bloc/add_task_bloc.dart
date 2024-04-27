import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_task_app/pages/productivity/todo/bloc/model/add_task_model.dart';
import 'package:multi_task_app/pages/productivity/todo/todo_service.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  AddTaskBloc() : super(AddTaskInitial()) {
    on<PostTask>((event, emit) async {
      try {
        emit(Loading());
        bool temp = await TaskServiceImp().addNewTask(event.task);
        if (temp) {
          emit(Success());
         // print(temp);
        } else {
          emit(Error());
        }
      } catch (e) {
        emit(Offline());
      }
    });
  }
}
