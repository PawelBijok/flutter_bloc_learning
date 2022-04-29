import 'package:bloc_learning/bloc/articles_bloc.dart';
import 'package:bloc_learning/core/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/widgets/error_message.dart';

class ArticleScreen extends StatefulWidget {
  final int id;
  const ArticleScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ArticlesBloc>().add(GetArticleByID(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article #${widget.id}'),
      ),
      body: BlocBuilder<ArticlesBloc, ArticlesState>(builder: (context, state) {
        if (state is SingleArticleError) {
          return ErrorMessage(state.message);
        }
        if (state is SingleArticleLoading) {
          return Loading();
        }
        if (state is SingleArticleLoaded) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  state.article.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  state.article.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }
        return Center(
          child: Text('Sorry! $state state is not supported yet'),
        );
      }),
    );
  }
}
