import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_task_app/pages/3dDrawer.dart';
import 'package:multi_task_app/pages/home_screen.dart';
import 'package:multi_task_app/pages/productivity/todo/bloc/bloc/delete_task_bloc.dart';
import 'package:multi_task_app/pages/productivity/todo/bloc/task_get_bloc.dart';
import 'package:multi_task_app/pages/productivity/todo/pages/taskPage.dart';
import 'package:multi_task_app/pages/productivity/todo/todo_service.dart';
import 'package:page_transition/page_transition.dart';

TaskServiceImp apiDelet = TaskServiceImp();

class ShowAddTaskPage extends StatefulWidget {
  @override
  State<ShowAddTaskPage> createState() => _ShowAddTaskPageState();
}

class _ShowAddTaskPageState extends State<ShowAddTaskPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskGetBloc()..add(GetTask()),
        ),
        BlocProvider(
          create: (context) => DeleteTaskBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: const Color(0xfff3dbcc),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            tooltip: 'Add',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => TaskPage(),
              );
            },
            backgroundColor: const Color(0xfff3dbcc),
            child: const Icon(
              Icons.add,
              color: Color(0xff5c666c),
            ),
          ),
          body: Stack(
            children: [
              BlocConsumer<DeleteTaskBloc, DeleteTaskState>(
                listener: (context, state) {
                  if (state is SuccessDelete) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowAddTaskPage(),
                        ));
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    action: SnackBarAction(label: "", onPressed: () {}),
                    content: const Text("Delete"),
                    duration: const Duration(seconds: 1),
                  ));
                },
                builder: (context, state) {
                  return BlocBuilder<TaskGetBloc, TaskGetState>(
                    builder: (context, state) {
                      if (state is Error) {
                        return const Center(
                          child: Text('Error'),
                        );
                      } else if (state is Success) {
                        return Container(
                          padding: const EdgeInsets.only(
                              top: 30, left: 35, right: 35, bottom: 40),
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    'To DO',
                                    style: GoogleFonts.bagelFatOne(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff5c666c),
                                    ),
                                    // style: TextStyle(
                                    //   fontWeight: FontWeight.bold,
                                    //   color: Color(0xff5c666c),
                                    //   fontSize: 28,
                                    // ),
                                  ).animate().fade(
                                      delay: .4.seconds, duration: .5.seconds),
                                  Text(
                                    '${state.tasks.length} Tasks',
                                    style: const TextStyle(
                                      color: Color(0xff5c666c),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                  
                                    ),
                                  ).animate().fade(
                                      delay: .6.seconds, duration: .7.seconds),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: SizedBox(
                                        width: double.infinity,
                                        height: 500,
                                        child: ListView.builder(
                                            itemCount: state.tasks.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              final item = state.tasks[index];
                                              return Dismissible(
                                                  key: Key(item.id.toString()),
                                                  direction: DismissDirection
                                                      .startToEnd,
                                                  background: Container(
                                                    alignment: Alignment.center,
                                                    color: Colors.red.shade200,
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(16),
                                                      child: Icon(
                                                        Icons.delete,
                                                        color:
                                                            Color(0xfff3dbcc),
                                                      ),
                                                    ),
                                                  ),
                                                  onDismissed:
                                                      (direction) async {
                                                    context
                                                        .read<DeleteTaskBloc>()
                                                        .add(DeleteTask(
                                                            id: state
                                                                .tasks[index]
                                                                .id));
                                                    setState(() {
                                                      state.tasks
                                                          .removeAt(index);
                                                    });
                                                  },
                                                  child: ListTile(
                                                    title: Text(
                                                      state.tasks[index]
                                                          .taskName,
                                                      style: TextStyle(
                                                          decoration: state
                                                                  .tasks[index]
                                                                  .check
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : null),
                                                    ),
                                                    trailing: Checkbox(
                                                      onChanged:
                                                          (newValue) async {
                                                        setState(() {
                                                          item.check =
                                                              !item.check;
                                                        });
                                                        TaskServiceImp
                                                            apiUpdate =
                                                            TaskServiceImp();
                                                        await apiUpdate
                                                            .updateTask(
                                                                state
                                                                    .tasks[
                                                                        index]
                                                                    .id,
                                                                item.check);
                                                      },
                                                      value: item.check,
                                                      activeColor: const Color(
                                                          0xff5c666c),
                                                    ),
                                                    onTap: () {},
                                                  ).animate().fade(
                                                      delay: 1.seconds,
                                                      duration: 1.1.seconds));
                                            })
                                        // }),
                                        ),
                                  ).animate().fade(
                                      delay: .8.seconds, duration: .9.seconds)
                                ]),
                          ),
                        );
                      } else if (state is Offline) {
                        return const Center(
                          child: Text('No Internet'),
                        );
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Color(0xff5c666c),
                        ));
                      }
                    },
                  );
                },
              ),
              IconButton(
                onPressed: () {
                 // Navigator.pop(context);
                   Navigator.push(context, PageTransition(child:DrawerPage(), type:PageTransitionType.fade));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xff5c666c),
                ),
              ).animate().fade(delay: .2.seconds, duration: .3.seconds),
            ],
          ),
        );
      }),
    );
  }
}
