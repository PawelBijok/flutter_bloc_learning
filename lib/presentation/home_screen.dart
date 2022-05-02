import 'package:bloc_learning/core/widgets/error_message.dart';
import 'package:bloc_learning/core/widgets/loading.dart';
import 'package:bloc_learning/presentation/widgets/article_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/articles/articles_bloc.dart';
import '../models/article/article.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC Articles'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<ArticlesBloc>().add(LoadArticles());
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: BlocBuilder<ArticlesBloc, ArticlesState>(
        builder: (context, ArticlesState state) {
          return state.when(
              initial: (() => Loading()),
              loading: () => Loading(),
              loaded: (articles) {
                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final Article article = articles[index];
                    return ArticleItem(article);
                  },
                );
              },
              error: (error) => ErrorMessage(error));
        },
      ),
    );
  }
}
