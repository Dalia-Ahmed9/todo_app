import 'package:flutter/material.dart';

class Putting_Task_appBar extends StatelessWidget
    implements PreferredSizeWidget {
  Putting_Task_appBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Row(
        children: [
          Icon(Icons.arrow_back_ios_new_outlined),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(150);
}
