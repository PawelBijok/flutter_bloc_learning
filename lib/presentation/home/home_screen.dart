import 'package:bloc_learning/core/widgets/error_message.dart';
import 'package:bloc_learning/core/widgets/loading.dart';
import 'package:bloc_learning/presentation/home/widgets/articles_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/articles/articles_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC Articles'),
        actions: [
          IconButton(
              key: const Key('test__refresh-button'),
              onPressed: () {
                context.read<ArticlesBloc>().add(const LoadArticles());
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: BlocConsumer<ArticlesBloc, ArticlesState>(
        listener: (context, state) {
          state.when(
              initial: () {},
              loading: () {},
              loaded: (articles) {},
              loadedWithError: (_, message) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              },
              error: (_) {});
        },
        builder: (context, ArticlesState state) {
          return state.when(
              initial: (() => const Loading()),
              loading: () => const Loading(),
              loaded: (articles) => ArticlesList(articles: articles),
              loadedWithError: (articles, _) =>
                  ArticlesList(articles: articles),
              error: (error) => ErrorMessage(error));
        },
      ),
    );
  }
}
