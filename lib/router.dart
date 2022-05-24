import 'package:bloc_learning/models/album/album.dart';
import 'package:bloc_learning/presentation/details/details_screen.dart';
import 'package:bloc_learning/presentation/home/home_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: HomeScreen.routeName,
      builder: (_, __) => const HomeScreen(),
      routes: [
        GoRoute(
          path: DetailsScreen.routeName,
          builder: (_, GoRouterState state) {
            final String albumId = state.params['id'] ?? '';
            final Album? album = state.extra as Album?;
            if (album == null) {
              return const HomeScreen();
            }

            return DetailsScreen(
              albumId: albumId,
              album: album,
            );
          },
        ),
      ],
    ),
  ],
);
