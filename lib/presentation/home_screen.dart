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
        actions: [
          IconButton(
              onPressed: () {
                context.read<ArticlesBloc>().add(GetArticles());
              },
              icon: Icon(Icons.refresh))
        ],
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
          if (state is ArticlesError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            );
          }

          return Center(
            child: Text('We do not support "$state" state yet'),
          );
        },
      ),
    );
  }
}
