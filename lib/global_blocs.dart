import 'package:bloc_learning/cubits/details/details_cubit.dart';
import 'package:bloc_learning/cubits/home/home_cubit.dart';
import 'package:bloc_learning/cubits/theme/theme_cubit.dart';
import 'package:bloc_learning/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalBlocs extends StatelessWidget {
  const GlobalBlocs({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<HomeCubit>()..loadAlbums(),
        ),
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(
          create: (context) => getIt<DetailsCubit>(),
        ),
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
      ],
      child: child,
    );
  }
}
