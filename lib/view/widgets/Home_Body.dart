import 'package:flutter/material.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/model/storing_tasks.dart';
import 'package:notes_app/utils/common/colors.dart';
import 'package:notes_app/utils/common/extension.dart';
import 'package:notes_app/view/widgets/list_of_tasks.dart';

class Home_Body extends StatelessWidget {
  const Home_Body({
    super.key,
    required this.textTheme,
    required this.base,
    this.task,
  });

  final TextTheme textTheme;
  final Basewidget base;
  final List<Task>? task;

  //check value of circle indicator
  dynamic valueOfIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  // check done tasks
  int checkDoneTasks(List<Task> task) {
    int i = 0;
    for (Task doneTask in task) {
      if (doneTask.isCompleted) {
        i++;
      }
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 60),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //progress indicator
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    value: checkDoneTasks(task!) / valueOfIndicator(task!),
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(AppColor.primaryColor),
                  ),
                ),
                // space
                25.w,
                // task info
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Tasks",
                      style: textTheme.displayLarge,
                    ),
                    4.h,
                    Text(
                      "${checkDoneTasks(task!)} of ${valueOfIndicator(task!)} Tasks",
                      style: textTheme.titleMedium,
                    ),
                  ],
                )
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Divider(
                color: AppColor.primaryColor,
                thickness: 1,
              ),
            ),
          ),
          listOfTasks(
            tasks: task,
            base: base,
          )
        ],
      ),
    );
  }
}
