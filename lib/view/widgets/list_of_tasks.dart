import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/model/storing_tasks.dart';
import 'package:notes_app/utils/constants.dart';
import 'package:notes_app/view/widgets/task_widget.dart';

class listOfTasks extends StatelessWidget {
  listOfTasks({
    super.key,
    this.tasks,
    required this.base,
  });
  final List<Task>? tasks;
  final Basewidget base;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
          width: double.infinity,
          height: 745,
          child: tasks!.isNotEmpty
              ? ListView.builder(
                  itemCount: tasks!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    //get sing task to show in list
                    var task = tasks![index];
                    return Dismissible(
                      key: Key(task.id),
                      direction: DismissDirection.horizontal,
                      onDismissed: (_) {
                        base.dataStore.Delete_Task(task: task);
                        print('message deleted successfully');
                      },
                      background: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_outline),
                          Text(
                            " This task was deleted",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      child: Task_widget(
                        task: task,
                      ),
                    );
                  })
              : Column(
                  children: [
                    LottieBuilder.asset(
                      animation,
                      width: MediaQuery.of(context).size.width / 1.4,
                    ),
                    const Text(
                      ' All Tasks are Done',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ],
                )),
    );
  }
}
