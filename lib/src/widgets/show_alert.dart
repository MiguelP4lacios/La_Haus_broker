import 'package:flutter/material.dart';

void showAlert(BuildContext context, String title, String message) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ));
}
