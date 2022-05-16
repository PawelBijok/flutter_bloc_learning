import 'package:bloc_learning/bloc/article/article_bloc.dart';
import 'package:bloc_learning/extensions/extensions.dart';
import 'package:bloc_learning/presentation/core/widgets/error_message.dart';
import 'package:bloc_learning/presentation/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({required this.id, Key? key}) : super(key: key);
  final int id;

  static const routeName = '/articles/:articleId';

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
          initial: LoadingIndicator.new,
          loading: LoadingIndicator.new,
          loaded: (article) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    article.title,
                    style: context.theme.textTheme.headline5,
                  ),
                  Text(
                    article.content,
                    style: context.theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          },
          error: ErrorMessage.new,
        );
      }),
    );
  }
}
