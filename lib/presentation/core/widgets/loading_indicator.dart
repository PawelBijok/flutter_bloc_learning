import 'package:bloc_learning/extensions/extensions.dart';
import 'package:flutter/material.dart';

enum _LoadingIndicatorType { standard, floatingBottom, forSlivers }

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key})
      : _type = _LoadingIndicatorType.standard,
        super(key: key);

  const LoadingIndicator.floatingBottom({Key? key})
      : _type = _LoadingIndicatorType.floatingBottom,
        super(key: key);
  const LoadingIndicator.forSlivers({Key? key})
      : _type = _LoadingIndicatorType.forSlivers,
        super(key: key);

  final _LoadingIndicatorType _type;

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case _LoadingIndicatorType.standard:
        {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      case _LoadingIndicatorType.forSlivers:
        {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }

      case _LoadingIndicatorType.floatingBottom:
        {
          return Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: context.theme.colorScheme.background,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                    backgroundColor: context.theme.colorScheme.primaryContainer,
                    color: context.theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          );
        }
    }
  }
}
