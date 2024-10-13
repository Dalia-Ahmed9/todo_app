import 'package:flutter/material.dart';

class timeAndDateSelection extends StatelessWidget {
  const timeAndDateSelection({
    super.key,
    required this.textTheme,
    required this.title,
    required this.ontap,
    this.time,
  });

  final TextTheme textTheme;
  final String? time;
  final String title;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.all(20),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: textTheme.headlineSmall,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 80,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
              ),
              child: Center(
                  child: Text(
                '$time',
                style: textTheme.titleSmall,
              )),
            )
          ],
        ),
      ),
    );
  }
}
