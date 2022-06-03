import 'package:flutter/material.dart';

class Dialogs {
  static showErrorDialog(String message, BuildContext context,VoidCallback? voidCallback) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Okay'),
            onPressed:voidCallback
          )
        ],
      ),
    );
  }

  static SaveDialog(String message, BuildContext context,  VoidCallback? voidCallback) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        print('hiii');
      return  WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(message),
            content: Text(message),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Assign'),
                onPressed: voidCallback,
              ),
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );


      }
    );
  }
}
