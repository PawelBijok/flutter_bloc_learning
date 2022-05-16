import 'package:bloc_learning/bloc/articles/articles_bloc.dart';
import 'package:bloc_learning/extensions/extensions.dart';
import 'package:bloc_learning/presentation/core/widgets/error_message.dart';
import 'package:bloc_learning/presentation/core/widgets/loading_indicator.dart';
import 'package:bloc_learning/presentation/home/widgets/articles_list.dart';
import 'package:bloc_learning/presentation/home/widgets/refresh_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.appTitle),
        actions: const [
          RefreshButton(),
        ],
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticlesBloc, ArticlesState>(
      listener: (context, state) {
        state.maybeWhen(
          loadedWithError: (_, message) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      builder: (context, ArticlesState state) {
        return state.when(
          initial: () => const LoadingIndicator(),
          loading: () => const LoadingIndicator(),
          loaded: (articles) => ArticlesList(articles: articles),
          loadedWithError: (articles, _) => ArticlesList(articles: articles),
          error: ErrorMessage.new,
        );
      },
    );
  }
}
