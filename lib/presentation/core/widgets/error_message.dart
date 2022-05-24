import 'package:bloc_learning/extensions/extensions.dart';
import 'package:flutter/material.dart';

enum _ErrorMessageType {
  standard,
  forSlivers,
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage(this.message, {Key? key})
      : _errorMessageType = _ErrorMessageType.standard,
        super(key: key);
  const ErrorMessage.forSlivers(this.message, {Key? key})
      : _errorMessageType = _ErrorMessageType.forSlivers,
        super(key: key);
  final String message;

  final _ErrorMessageType _errorMessageType;

  @override
  Widget build(BuildContext context) {
    final errorWidget = Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: context.theme.textTheme.headlineSmall,
        ),
      ),
    );
    switch (_errorMessageType) {
      case _ErrorMessageType.standard:
        return errorWidget;

      case _ErrorMessageType.forSlivers:
        return SliverFillRemaining(
          child: errorWidget,
        );
    }
  }
}
