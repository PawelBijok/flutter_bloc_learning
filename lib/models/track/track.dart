import 'package:freezed_annotation/freezed_annotation.dart';

part 'track.freezed.dart';
part 'track.g.dart';

@freezed
class Track with _$Track {
  const factory Track({
    required final String id,
    required final String name,
    @JsonKey(name: 'duration_ms') required int duration,
  }) = _Track;

  factory Track.fromJson(dynamic json) => _$TrackFromJson(json);
}
