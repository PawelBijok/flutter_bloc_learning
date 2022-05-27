// This file is "main.dart"
import 'package:bloc_learning/models/artist/artist.dart';
import 'package:bloc_learning/models/image/image.dart';
import 'package:bloc_learning/models/tracks/tracks.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'album.freezed.dart';

part 'album.g.dart';

@freezed
class Album with _$Album {
  const factory Album({
    required final String id,
    required final String name,
    @JsonKey(name: 'total_tracks') required final int totalTracks,
    @JsonKey(name: 'release_date') required final String releaseDate,
    required final List<Image> images,
    final List<Artist>? artists,
    final String? label,
    final int? popularity,
    final Tracks? tracks,
  }) = _Album;

  factory Album.fromJson(dynamic json) => _$AlbumFromJson(json);
}
