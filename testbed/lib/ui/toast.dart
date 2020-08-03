import 'package:flutter/material.dart';

void showTip(BuildContext context, String text) {
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(text),));
}