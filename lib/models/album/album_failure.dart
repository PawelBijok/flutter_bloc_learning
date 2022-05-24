import 'package:freezed_annotation/freezed_annotation.dart';

part 'album_failure.freezed.dart';

@freezed
class AlbumFailure with _$AlbumFailure {
  // TODO: more failure options
  const factory AlbumFailure.unexpected() = _Unexpected;
}
