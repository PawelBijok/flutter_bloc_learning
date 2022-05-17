import 'package:bloc_learning/extensions/extensions.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage(this.message, {Key? key}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: context.theme.textTheme.headlineSmall,
        ),
      ),
    );
  }
}
