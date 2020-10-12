import 'package:flutter/material.dart';

void showAlert(BuildContext context, String massage) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Invalid Data'),
            content: Text(massage),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ));
}
