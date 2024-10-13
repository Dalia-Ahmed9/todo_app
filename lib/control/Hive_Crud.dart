import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/model/storing_tasks.dart';

class HiveDataStore {
  //box Name
  static const boxName = 'textBox';

//our current box with all the saved data inside Box<Task>
  final Box<Task> box = Hive.box<Task>(boxName);

  //methods of crud
  //*****************************************************

  //add new task to box
  Future<void> Add_Task({required Task task}) async {
    await box.put(task.id, task);
  }

  //show task
  Future<Task?> get_Task({required String id}) async {
    return box.get(id);
  }

  //update task
  Future<void> update_Task({required Task task}) async {
    await task.save();
  }

  //Delete task
  Future<void> Delete_Task({required Task task}) async {
    await task.delete();
  }

  //listen to box changes
  //using this method we will listen to box changes and update the ui changes

  ValueListenable<Box<Task>> listeToTask() => box.listenable();
}
