import 'package:freezed_annotation/freezed_annotation.dart';

part 'external_urls_dto.freezed.dart';
part 'external_urls_dto.g.dart';

@freezed
class ExternalUrlsDto with _$ExternalUrlsDto {
  const factory ExternalUrlsDto({
    required final String spotify,
  }) = _ExternalUrlsDto;

  factory ExternalUrlsDto.fromJson(Map<String, dynamic> json) => _$ExternalUrlsDtoFromJson(json);
}
