import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:notes_app/main.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

const String animation = 'asset/lottie_files/Animation - 1722037628437.json';
const String ImageUrl = 'asset/images/3551739.jpg';

const String AddNote = ' Add Note';

//empty title or subtitle text field warning
emptywarning(BuildContext context) {
  return FToast.toast(context,
      msg: 'OOPS MSG',
      color: Color.fromARGB(255, 206, 201, 201),
      subMsg: 'you must fill all fields',
      subMsgStyle: TextStyle(fontSize: 15),
      msgStyle: TextStyle(color: Colors.red),
      corner: 20,
      duration: 2000,
      padding: const EdgeInsets.all(20));
}

// nothing entered when user try to edit or update the current task
repeatingwarning(BuildContext context) {
  return FToast.toast(context,
      msg: 'OOPS MSG',
      color: Color.fromARGB(255, 206, 201, 201),
      subMsg: 'task still the same ',
      subMsgStyle: TextStyle(fontSize: 15),
      msgStyle: TextStyle(color: Colors.red),
      corner: 20,
      duration: 2000,
      padding: const EdgeInsets.all(20));
}

//no task warning dialog for delete

noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(context,
      message:
          'There is no task for Delete \n try adding some then try to delete',
      buttonText: 'Okey', onTapDismiss: () {
    Navigator.pop(context);
  }, panaraDialogType: PanaraDialogType.warning);
}

//Delete all tasks from Data Base dialog

dynamic deleteAllTasks(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    message:
        ' Do You really want to Delete all tasks?you will not able to undo this action  ',
    confirmButtonText: 'Yes',
    cancelButtonText: 'No',
    onTapConfirm: () {
      // we will clear all box data using this command
      Basewidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    onTapCancel: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}
