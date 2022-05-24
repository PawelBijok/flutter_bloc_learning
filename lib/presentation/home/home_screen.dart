import 'package:bloc_learning/cubits/home/home_cubit.dart';
import 'package:bloc_learning/extensions/extensions.dart';
import 'package:bloc_learning/presentation/core/widgets/error_message.dart';
import 'package:bloc_learning/presentation/core/widgets/loading_indicator.dart';
import 'package:bloc_learning/presentation/home/widgets/albums_grid.dart';
import 'package:bloc_learning/presentation/home/widgets/drawer/home_drawer.dart';
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
      ),
      drawer: const HomeDrawer(),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.when(
          initial: () => const LoadingIndicator(),
          loadingInProgress: () => const LoadingIndicator(),
          loadedSuccessfully: (albums) => AlbumsGrid(albums: albums),
          loadedWithError: ErrorMessage.new,
        );
      },
    );
  }
}
