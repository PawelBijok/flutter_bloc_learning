import 'package:bloc_learning/core/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/article/article_bloc.dart';
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
    context.read<ArticleBloc>().add(LoadSingleArticle(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article #${widget.id}'),
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
        return state.when(
            initial: () {
              return Loading();
            },
            loading: () {
              return Loading();
            },
            loaded: (article) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      article.title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      article.content,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            },
            error: (message) => ErrorMessage(message));
      }),
    );
  }
}
