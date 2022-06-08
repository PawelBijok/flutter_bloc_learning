import 'package:freezed_annotation/freezed_annotation.dart';

part 'track.freezed.dart';
part 'track.g.dart';

@freezed
class Track with _$Track {
  const Track._();
  const factory Track({
    required final String id,
    required final String name,
    @JsonKey(name: 'track_number') required final int trackNumber,
    @JsonKey(name: 'duration_ms') required int duration,
  }) = _Track;

  String get durationString {
    int time = duration;
    final centiseconds = (time % 1000) ~/ 10;
    if (centiseconds > 50) {
      time += 1000;
    }
    time ~/= 1000;
    final int seconds = time % 60;
    time ~/= 60;
    final int minutes = time % 60;
    time ~/= 60;
    final int hours = time;
    if (hours > 0) {
      return '$hours:${_twoDigits(minutes)}:${_twoDigits(seconds)}';
    }

    return '$minutes:${_twoDigits(seconds)}';
  }

  String _twoDigits(int time) {
    return "${time < 10 ? '0' : ''}$time";
  }

  factory Track.fromJson(dynamic json) => _$TrackFromJson(json);
}
