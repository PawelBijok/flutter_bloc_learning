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
        title: Text('BLoC Articles'),
      ),
      body: BlocBuilder<ArticlesBloc, ArticlesState>(
        builder: (context, ArticlesState state) {
          if (state is ArticlesInitial || state is ArticlesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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

          return Center(
            child: Text('We do not support "$state" state yes'),
          );
        },
      ),
    );
  }
}
