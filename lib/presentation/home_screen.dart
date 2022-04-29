import 'package:bloc_learning/core/widgets/error_message.dart';
import 'package:bloc_learning/core/widgets/loading.dart';
import 'package:bloc_learning/presentation/widgets/article_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/articles_bloc.dart';
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
                context.read<ArticlesBloc>().add(GetArticles());
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: BlocBuilder<ArticlesBloc, ArticlesState>(
        buildWhen: (previous, current) {
          if (current is SingleArticleLoaded ||
              current is SingleArticleLoading ||
              current is SingleArticleError) {
            return false;
          }
          return true;
        },
        builder: (context, ArticlesState state) {
          if (state is ArticlesInitial || state is ArticlesLoading) {
            return const Loading();
          }
          if (state is ArticlesLoaded) {
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final Article article = state.articles[index];
                return ArticleItem(article);
              },
            );
          }
          if (state is ArticlesError) {
            return ErrorMessage(state.message);
          }

          return Center(
            child: Text('We do not support "$state" state yet'),
          );
        },
      ),
    );
  }
}
