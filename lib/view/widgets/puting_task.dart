import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/model/storing_tasks.dart';
import 'package:notes_app/utils/common/colors.dart';
import 'package:notes_app/utils/common/extension.dart';
import 'package:notes_app/utils/constants.dart';
import 'package:notes_app/view/widgets/Rep_text.dart';
import 'package:notes_app/view/widgets/dateSelection.dart';
import 'package:notes_app/view/widgets/timeAndDateSelection.dart';

class Putting_task extends StatefulWidget {
  Putting_task(
      {super.key,
      required this.titletaskController,
      required this.descriptiontaskController,
      required this.task});

  final TextEditingController? titletaskController;
  final TextEditingController? descriptiontaskController;
  final Task? task;

  State<Putting_task> createState() => _Putting_taskState();
}

//show selected time as string formate

@override
class _Putting_taskState extends State<Putting_task> {
  var title;
  var subtitle;
  DateTime? time;
  DateTime? date;
  // if any task exist return true otherwise false
  bool isTaskAlreadyExist() {
    if (widget.titletaskController?.text == null &&
        widget.descriptiontaskController?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  String showTime(DateTime? time) {
    try {
      if (time == null) {
        final now = DateTime.now();
        return DateFormat('hh:mm a').format(now).toString();
        // print("Error: Time is null, returning default value.");
        // return "No time selected"; // يمكنك إرجاع قيمة افتراضية أو عرض رسالة
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } catch (e) {
      print("Error formatting time: $e");
      return "Error formatting time"; // يمكنك إرجاع رسالة خطأ للمستخدم
    }
  }

  String showdate(DateTime? date) {
    try {
      if (widget.task?.createdAtDate == null) {
        if (date == null) {
          print("Returning current time.");
          return DateFormat.yMMMEd().format(DateTime.now()).toString();
        } else {
          print("Returning provided time.");
          return DateFormat.yMMMEd().format(date).toString();
        }
      } else {
        print("Returning task created time.");
        return DateFormat.yMMMEd()
            .format(widget.task!.createdAtDate)
            .toString();
      }
    } catch (e) {
      print("Error formatting time: $e");
      return "Error formatting time";
    }
  }

  //Main function for creating or updating tasks
  dynamic isTaskAlreadyExistUpdateOtherWiseCreate() {
    if (widget.titletaskController?.text != null &&
        widget.descriptiontaskController?.text != null) {
      try {
        widget.titletaskController?.text = title;
        widget.descriptiontaskController?.text = subtitle;

        widget.task?.save();
        Navigator.pop(context);
      } catch (e) {
        // if user want to update task but entered nothing , we will show this warning
        repeatingwarning(context);
      }
    } else {
      // here we will create a new task
      if (title != null && subtitle != null) {
        var task = Task.create(
            title: title,
            subtitle: subtitle,
            createdAtDate: date,
            createdAtTime: time);
        // here we add task to hive data base
        Basewidget.of(context).dataStore.Add_Task(task: task);
        Navigator.pop(context);
        print(task.title);
        print(task.subtitle);
        print(task.createdAtDate);
        print(task.createdAtTime);
      } else {
        // warning
        emptywarning(context);
      }
    }
  }

// for deleting tasks
  dynamic deleteTask() {
    return widget.task?.delete();
  }

  void initState() {
    // time = DateTime.now(); // تعيين الوقت الحالي كقيمة افتراضية
    date = DateTime.now();
    print("Current time value: $time");
// print("Minute divider: $minuteDivider");
// print("Value range: $valueRange");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios_new_outlined)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 70,
                          child: Divider(
                            color: AppColor.primaryColor,
                            thickness: 2,
                          )),
                      isTaskAlreadyExist()
                          ? Text(
                              'Add New Task ',
                              style: textTheme.titleLarge,
                            )
                          : Text(' Update Current Task',
                              style: textTheme.titleLarge),
                      SizedBox(
                          width: 70,
                          child: Divider(
                            color: AppColor.primaryColor,
                            thickness: 2,
                          )),
                    ],
                  ),
                ),

                //for adding a task

                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            " What are you planning for 🤔 ? ",
                            style: textTheme.titleMedium,
                          ),
                        ),
                      ),
                      RepTextField(
                        controller: widget.titletaskController,
                        isDescription: false,
                        onChanged: (String inputText) {
                          title = inputText;
                        },
                        onfieldSubmitted: (String inputText) {
                          title = inputText;
                        },
                      ),
                      20.h,
                      RepTextField(
                        controller: widget.descriptiontaskController,
                        isDescription: true,
                        onChanged: (String inputsubtitle) {
                          subtitle = inputsubtitle;
                        },
                        onfieldSubmitted: (String inputSubtitle) {
                          subtitle = inputSubtitle;
                        },
                      ),
                    ],
                  ),
                ),

                timeAndDateSelection(
                  textTheme: textTheme,
                  title: 'Time',
                  time: showTime(time), // لعرض الوقت الحالي أو الوقت المحدد
                  ontap: () {
                    // استخدم showTimePicker لفتح نافذة اختيار الوقت
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((pickedTime) {
                      if (pickedTime != null) {
                        // التأكد من أن الوقت المحدد صحيح
                        try {
                          final now = DateTime.now();
                          final selectedTime = DateTime(
                            now.year,
                            now.month,
                            now.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                          // استخدام setState لتحديث الواجهة
                          setState(() {
                            time = selectedTime;
                          });
                        } catch (e) {
                          print("Error setting selected time: $e");
                        }
                      }
                    }).catchError((error) {
                      // في حالة حدوث أي خطأ أثناء اختيار الوقت
                      print("Error in showTimePicker: $error");
                    });
                  },
                ),

                // child: TimePickerWidget(
                //   dateFormat: 'HH : mm ',
                //   minuteDivider: 1,
                //   onChange: (_, __) {},
                //   onConfirm: (dateTime, _) {
                //     try {
                //       setState(() {
                //         time =
                //             dateTime; // التأكد من أن time يتم تحديثه هنا
                //       });
                //     } catch (e) {
                //       print("Error selecting time: $e");
                //     }

                //     // setState(() {
                //     //   if (widget.task?.createdAtTime == null) {
                //     //     time = dateTime;
                //     //   } else {
                //     //     widget.task!.createdAtTime = dateTime;
                //     //   }
                //     // });
                //     // setState(() {
                //     //   time = dateTime;
                //     // });
                //   },
                // ),

                DateSelection(
                  textTheme: textTheme,
                  title: 'Date',
                  date: showdate(date),
                  ontap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: date ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030, 5, 4),
                    );
                    if (picked != null) {
                      setState(() {
                        date = picked;
                      });
                    }
                  },
                ),

                // Bottom side buttons
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: isTaskAlreadyExist()
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      isTaskAlreadyExist()
                          ? Container()
                          : MaterialButton(
                              onPressed: () {
                                log("deleting task");
                                deleteTask();
                                print('message deleted successfully');
                                Navigator.pop(context);
                              },
                              minWidth: 150,
                              color: Colors.white,
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              height: 55,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: AppColor.primaryColor,
                                    size: 20,
                                  ),
                                  3.w,
                                  Text(
                                    'Delete Task',
                                    style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                      MaterialButton(
                        onPressed: () {
                          isTaskAlreadyExistUpdateOtherWiseCreate();
                          log("adding task");
                          // Navigator.pop(context);
                        },
                        minWidth: 150,
                        color: AppColor.primaryColor,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        height: 55,
                        child: Text(
                          isTaskAlreadyExist() ? 'Add Task' : " Update Task",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
