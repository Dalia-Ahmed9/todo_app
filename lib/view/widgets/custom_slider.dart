import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/utils/common/colors.dart';
import 'package:notes_app/utils/common/extension.dart';
import 'package:notes_app/utils/constants.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  final List<IconData> Icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_2_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info,
  ];
  final List<String> text = [
    ' Home ',
    ' Profile ',
    ' Settings ',
    ' Details ',
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 90,
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: AppColor.primaryGradientColor,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(ImageUrl),
          ),
          8.h,
          Text(
            "Dalia Ahmed",
            style: textTheme.displayMedium,
          ),
          Text('Flutter dev', style: textTheme.displaySmall),
          Container(
            width: double.infinity,
            height: 400,
            child: ListView.builder(
                itemCount: Icons.length,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    child: ListTile(
                      leading: Icon(
                        Icons[index],
                        color: Colors.white,
                      ),
                      title: Text(
                        text[index],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
