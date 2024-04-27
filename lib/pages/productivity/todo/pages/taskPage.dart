import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_task_app/pages/productivity/todo/bloc/bloc/add_task_bloc.dart';
import 'package:multi_task_app/pages/productivity/todo/bloc/model/add_task_model.dart';
import 'package:multi_task_app/pages/productivity/todo/pages/show_add_task.dart';
import 'package:multi_task_app/pages/productivity/todo/todo_service.dart';

final _formKey = GlobalKey<FormState>();

class TaskPage extends StatelessWidget {
  TaskPage({super.key});

  final TextEditingController _taskNumber = TextEditingController();
  final TextEditingController _taskName = TextEditingController();

  TaskServiceImp taskayh = TaskServiceImp();

  @override
  Widget build(BuildContext context) {
    return
        //i add it in the myapp
        BlocProvider(
      create: (context) => AddTaskBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: const Color(0xfff3dbcc),
          body: BlocListener<AddTaskBloc, AddTaskState>(
            listener: (context, state) {
              if (state is Success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xff5c666c),
                    action: SnackBarAction(label: "", onPressed: () {}),
                    content: const Text("Thank you for adding new task"),
                    duration: const Duration(seconds: 1),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowAddTaskPage()),
                );
              } else if (State is Error) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  action: SnackBarAction(label: "", onPressed: () {}),
                  content: const Text("Sorry you can`t add"),
                  duration: const Duration(seconds: 1),
                ));
              } else if (State is Offline) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.grey,
                  action: SnackBarAction(label: "", onPressed: () {}),
                  content: const Text("You are offline"),
                  duration: const Duration(seconds: 1),
                ));
              }
            },
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                        child: Text(
                      "Add Task",
                      style: TextStyle(
                          fontSize: 36,
                          color: Color(0xff5c666c),
                          fontWeight: FontWeight.bold),
                    )).animate().fade(delay: .2.seconds, duration: .3.seconds),
                    // Padding(
                    //   padding: const EdgeInsets.all(10),
                    //   child: TextFormField(
                    //     cursorColor: const Color(0xff5c666c),
                    //     controller: _taskNumber,
                    //     decoration: const InputDecoration(
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Color(0xff5c666c),
                    //           width: 3,
                    //         ),
                    //       ),
                    //       focusedErrorBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.red, width: 3),
                    //       ),
                    //       errorBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.red),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //         color: Color(0xff5c666c),
                    //       )),
                    //       //border: OutlineInputBorder(),
                    //       label: Text(
                    //         'taskNumber',
                    //         style: TextStyle(fontSize: 10),
                    //       ),
                    //     ),
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return 'please enter the task number';
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //   ),
                    // ).animate().fade(delay: .4.seconds, duration: .5.seconds),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        cursorColor: const Color(0xff5c666c),
                        controller: _taskName,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff5c666c),
                              width: 3,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 3),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xff5c666c),
                          )),
                          // border: OutlineInputBorder(),
                          label: Text(
                            'Task name ',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter the task name';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ).animate().fade(delay: .4.seconds, duration: .5.seconds),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AddTaskBloc>().add(
                                  PostTask(
                                    task: AddTask(
                                      taskNumber:
                                          num.tryParse(_taskNumber.text) ?? 0.0,
                                      taskName: _taskName.text,
                                      check: false,
                                    ),
                                  ),
                                );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff5c666c),
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 350,
                          height: 50,
                          child: const Center(
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xfff3dbcc),
                              ),
                            ),
                          ).animate().fade(delay: .8.seconds, duration: .9.seconds),
                        ),
                      ),
                    ).animate().fade(delay: .6.seconds, duration: .7.seconds),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
