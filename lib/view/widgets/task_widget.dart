import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/model/storing_tasks.dart';
import 'package:notes_app/utils/common/colors.dart';
import 'package:notes_app/view/widgets/puting_task.dart';

class Task_widget extends StatefulWidget {
  Task_widget({
    super.key,
    required this.task,
  });
  final Task task;

  @override
  State<Task_widget> createState() => _Task_widgetState();
}

class _Task_widgetState extends State<Task_widget> {
  TextEditingController textEditingControllerfortitle = TextEditingController();

  TextEditingController textEditingControllerforsubtitle =
      TextEditingController();

  @override
  void initState() {
    textEditingControllerfortitle.text = widget.task.title;
    textEditingControllerforsubtitle.text = widget.task.subtitle;
    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerforsubtitle.dispose();
    textEditingControllerfortitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (ctx) => Putting_task(
                    titletaskController: textEditingControllerfortitle,
                    descriptiontaskController: textEditingControllerforsubtitle,
                    task: widget.task)));
      },
      child: AnimatedContainer(
        duration: Duration(microseconds: 700),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: widget.task.isCompleted
              ? AppColor.primaryColor.withOpacity(0.3)
              : Colors.white,
          borderRadius: BorderRadius.circular(
            8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 4),
              blurRadius: 10,
            )
          ],
        ),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              widget.task.isCompleted = !widget.task.isCompleted;
              widget.task.save();
              print('message is completed');
            },
            child: AnimatedContainer(
              duration: Duration(microseconds: 700),
              decoration: BoxDecoration(
                color: widget.task.isCompleted
                    ? AppColor.primaryColor
                    : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 0.8),
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              textEditingControllerfortitle.text,
              style: TextStyle(
                color: widget.task.isCompleted
                    ? AppColor.primaryColor
                    : Colors.black,
                fontWeight: FontWeight.w700,
                decoration:
                    widget.task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textEditingControllerforsubtitle.text,
                style: TextStyle(
                  fontSize: 14,
                  color: widget.task.isCompleted
                      ? AppColor.primaryColor
                      : Colors.black,
                  fontWeight: FontWeight.w300,
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('hh:mm a').format(widget.task.createdAtTime),
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.task.isCompleted
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMEd().format(widget.task.createdAtDate),
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.task.isCompleted
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
