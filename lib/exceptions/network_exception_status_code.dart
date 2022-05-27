import 'package:bloc_learning/extensions/extensions.dart';
import 'package:flutter/material.dart';

class NetworkExceptionStatusCode implements Exception {
  NetworkExceptionStatusCode(
    this.statusCode,
  );
  final int statusCode;

  @override
  String toString() => 'NetworkExceptionStatusCode: $statusCode';

  String description(BuildContext context) {
    final String errorMessage;
    switch (statusCode) {
      case 400:
        errorMessage = context.l10n.error400;
        break;
      case 401:
        errorMessage = context.l10n.error401;
        break;

      case 404:
        errorMessage = context.l10n.error404;
        break;

      default:
        errorMessage = context.l10n.errorUnknown;
    }

    return '$statusCode: $errorMessage';
  }
}
