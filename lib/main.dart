import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/control/Hive_Crud.dart';
import 'package:notes_app/model/storing_tasks.dart';
import 'package:notes_app/utils/themes/light_Themes.dart';
import 'package:notes_app/view/home_view.dart';

void main() async {
  //init hive DB before running app
  await Hive.initFlutter();
  //register Hive adapter
  Hive.registerAdapter<Task>(TaskAdapter());
  //open abox
  Box box = await Hive.openBox<Task>(HiveDataStore.boxName);

  //this step is not necessary
  //delete data from previous day
  box.values.forEach((task) {
    if (task.createdAtTime.day != DateTime.now().day) {
      task.delete();
    } else {}
  });
  runApp(Basewidget(child: const MyApp()));
}

//the inherited widget provides us with a conventient way to pass data between
// widgets while developing an app ,
// you will need some data from your parent's widgets or grant parent widgets
class Basewidget extends InheritedWidget {
  Basewidget({Key? key, required this.child}) : super(child: child, key: key);
  final HiveDataStore dataStore = HiveDataStore();
  final Widget child;

  static Basewidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<Basewidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError('Could not find ancestor widget of type base widget');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme(),
      debugShowCheckedModeBanner: false,
      home: homeView(),
    );
  }
}
