import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'storing_tasks.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final id;
  @HiveField(1)
  late var title;
  @HiveField(2)
  late var subtitle;
  @HiveField(3)
  late DateTime createdAtTime;
  @HiveField(4)
  late DateTime createdAtDate;
  @HiveField(5)
  late bool isCompleted;

  Task({
    required this.id,
    required this.subtitle,
    required this.createdAtDate,
    required this.createdAtTime,
    required this.isCompleted,
    required this.title,
  });

//create new task

  factory Task.create({
    required title,
    required subtitle,
    DateTime? createdAtDate,
    DateTime? createdAtTime,
  }) =>
      Task(
          id: const Uuid().v1(),
          subtitle: subtitle ?? "",
          createdAtDate: createdAtDate ?? DateTime.now(),
          createdAtTime: createdAtTime ?? DateTime.now(),
          isCompleted: false,
          title: title ?? "");
}
