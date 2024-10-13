import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/model/storing_tasks.dart';
import 'package:notes_app/view/widgets/Home_Body.dart';
import 'package:notes_app/view/widgets/Home_appBar.dart';
import 'package:notes_app/view/widgets/adding_tasks.dart';
import 'package:notes_app/view/widgets/custom_slider.dart';

class homeView extends StatefulWidget {
  homeView({super.key});

  @override
  State<homeView> createState() => _homeViewState();
}

GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

// ignore: camel_case_types
class _homeViewState extends State<homeView> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final base = Basewidget.of(context);
    return ValueListenableBuilder(
        valueListenable: base.dataStore.listeToTask(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();
          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: addingTask(),
            body: SliderDrawer(
                key: drawerKey,
                isDraggable: false,
                animationDuration: 1000,
                slider: const CustomSlider(),
                appBar: HomeAppBar(
                  drawerKey: drawerKey,
                ),
                child: Home_Body(
                  textTheme: textTheme,
                  base: base,
                  task: tasks,
                )),
          );
        });

    //
  }
}
