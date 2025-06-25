import 'package:flutter/material.dart';

class AppDialog {
  static void showErrorDialog(
      {required BuildContext context,
      String title = "Something Wrong",
      required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static void showSuccessDialog(
      {required BuildContext context,
      String title = "Success",
      required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static void showConfirmDialog(
      {required BuildContext context,
      String title = "Confirm",
      required String message,
      required VoidCallback onOkPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onOkPressed();
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }
static void showConfirmDialogChoice({
  required BuildContext context,
  String title = "Confirm",
  required Map<String, VoidCallback> actions,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title,textAlign: TextAlign.center,),
        content: Icon(Icons.question_mark_outlined,color: Colors.grey,size: 50,),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: actions.entries.map((entry) {
          return TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              entry.value();
            },
            child: Text(entry.key),
          );
        }).toList(),
      );
    },
  );
}

static void showNotifSuccessDialog(
      {required BuildContext context,
      String title = "Success",
      }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text(title,textAlign: TextAlign.center,),
          content: Icon(Icons.check_circle_outline_outlined,color: Colors.lightGreen,size: 40,),
        );
      },
    );
  }
}