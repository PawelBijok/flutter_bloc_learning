import 'package:bloc_learning/models/dtos/albums_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result_dto.freezed.dart';
part 'result_dto.g.dart';

@freezed
class ResultDto with _$ResultDto {
  const factory ResultDto({
    required final AlbumsDto albums,
  }) = _ResultDto;

  factory ResultDto.fromJson(Map<String, dynamic> json) => _$ResultDtoFromJson(json);
}
