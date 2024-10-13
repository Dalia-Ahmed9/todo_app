import 'package:flutter/material.dart';
import 'package:notes_app/utils/common/colors.dart';
import 'package:notes_app/utils/constants.dart';

class RepTextField extends StatelessWidget {
  const RepTextField({
    super.key,
    required this.controller,
    required this.isDescription,
    this.onfieldSubmitted,
    this.onChanged,
  });
  final TextEditingController? controller;
  final bool isDescription;
  final Function(String)? onfieldSubmitted;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        title: TextFormField(
          controller: controller,

          maxLines: isDescription ? null : 3,
          cursorHeight: isDescription ? null : 50,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
              counter: Container(),
              hintText: isDescription ? AddNote : null,
              border: isDescription ? null : InputBorder.none,
              prefixIcon: isDescription
                  ? const Icon(
                      Icons.bookmark_border,
                      color: Colors.grey,
                    )
                  : null,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
              ),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey, width: 2))),
          onFieldSubmitted: onfieldSubmitted,
          onChanged: onChanged,
          // نكمل التيكست فيلد  والبوتومز بتاعة اضافة التاسكات
        ),
      ),
    );
  }
}
