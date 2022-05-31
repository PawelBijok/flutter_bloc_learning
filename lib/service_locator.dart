import 'package:bloc_learning/cubits/details/details_cubit.dart';
import 'package:bloc_learning/cubits/home/home_cubit.dart';
import 'package:bloc_learning/cubits/theme/theme_cubit.dart';
import 'package:bloc_learning/data/api/spotify_api.dart';
import 'package:bloc_learning/data/interceptors/auth_error_retry_interceptor.dart';
import 'package:bloc_learning/data/interceptors/dio_request_retrier.dart';
import 'package:bloc_learning/data/interceptors/headers_incerceptor.dart';
import 'package:bloc_learning/data/repositories/albums_repository.dart';
import 'package:bloc_learning/data/repositories/token_repository.dart';
import 'package:bloc_learning/data/services/token_service.dart';
import 'package:bloc_learning/resources/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<Logger>(Logger());

  getIt.registerLazySingleton<FlutterSecureStorage>(
    FlutterSecureStorage.new,
  );

  // DIO RELATED & API
  getIt.registerFactory<Dio>(Dio.new);

  getIt.registerLazySingleton(
    () => TokenService(
      dio: getIt<Dio>(),
    ),
  );

  getIt.registerLazySingleton<HeadersIncerceptor>(
    () => HeadersIncerceptor(
      tokenRepository: getIt<TokenRepository>(),
    ),
  );

  getIt.registerLazySingleton<DioRequestRetrier>(
    () {
      final dio = getIt<Dio>();
      dio.interceptors.add(getIt<HeadersIncerceptor>());

      return DioRequestRetrier(
        dio: dio,
      );
    },
  );

  getIt.registerLazySingleton<AuthErrorRetryInterceptor>(
    () => AuthErrorRetryInterceptor(
      tokenRepository: getIt<TokenRepository>(),
      tokenService: getIt<TokenService>(),
      requestRetrier: getIt<DioRequestRetrier>(),
    ),
  );

  getIt.registerLazySingleton<SpotifyApi>(
    () {
      final dio = getIt<Dio>();
      dio.options = BaseOptions(baseUrl: Constants.spotifyBaseUrl);
      dio.interceptors.addAll([
        getIt<HeadersIncerceptor>(),
        getIt<AuthErrorRetryInterceptor>(),
      ]);

      return SpotifyApi(
        dio: dio,
      );
    },
  );

  // REPOSITORIES
  getIt.registerLazySingleton<AlbumsRepository>(
    () => AlbumsRepositoryImplementation(
      getIt<SpotifyApi>(),
    ),
  );

  getIt.registerLazySingleton<TokenRepository>(
    () => TokenRepositoryImplementation(
      secureStorage: getIt<FlutterSecureStorage>(),
    ),
  );

  // CUBITS
  getIt.registerSingleton<HomeCubit>(
    HomeCubit(
      getIt<AlbumsRepository>(),
    ),
  );

  getIt.registerSingleton<DetailsCubit>(
    DetailsCubit(
      getIt<AlbumsRepository>(),
    ),
  );

  getIt.registerSingleton<ThemeCubit>(
    ThemeCubit(),
  );
}
