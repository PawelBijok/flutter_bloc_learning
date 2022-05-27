import 'package:bloc_learning/models/track/track.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracks.freezed.dart';
part 'tracks.g.dart';

@freezed
class Tracks with _$Tracks {
  const factory Tracks({
    required String href,
    required List<Track> items,
  }) = _Tracks;

  factory Tracks.fromJson(dynamic json) => _$TracksFromJson(json);
}
