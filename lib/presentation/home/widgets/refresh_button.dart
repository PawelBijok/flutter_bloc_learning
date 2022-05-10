import 'package:bloc_learning/bloc/articles/articles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<ArticlesBloc>().add(
              const LoadArticles(),
            );
      },
      icon: const Icon(
        Icons.refresh,
      ),
    );
  }
}
