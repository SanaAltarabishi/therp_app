part of 'add_task_bloc.dart';


sealed class AddTaskEvent {}

class PostTask extends AddTaskEvent {
  AddTask task;
  PostTask({
    required this.task,
  });
}
