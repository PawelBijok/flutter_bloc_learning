import 'package:bloc_learning/models/album/album.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'albums_dto.freezed.dart';
part 'albums_dto.g.dart';

@freezed
class AlbumsDto with _$AlbumsDto {
  const factory AlbumsDto({
    required final String href,
    required final List<Album> items,
  }) = _AlbumsDto;

  factory AlbumsDto.fromJson(Map<String, dynamic> json) => _$AlbumsDtoFromJson(json);
}
