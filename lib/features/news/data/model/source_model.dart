import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:news/features/news/domain/entitys/source.dart';

part 'source_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class SourceModel {
  @HiveField(0)
  final String name;

  SourceModel({required this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      _$SourceModelFromJson(json);

  Map<String, dynamic> toJson() => _$SourceModelToJson(this);

  static SourceModel toModel(Source entity) {
    return SourceModel(name: entity.name);
  }

  Source toEntity() {
    return Source(name: name);
  }
}
