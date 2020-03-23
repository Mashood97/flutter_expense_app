import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String title;
  final Function handler;
  
  AdaptiveFlatButton({this.title,this.handler});
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: handler,
    )
        : FlatButton(
      textColor: Theme.of(context).primaryColor,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: handler,
    );
  }
}
