// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchRespJModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRespJModel _$SearchRespJModelFromJson(Map<String, dynamic> json) {
  return SearchRespJModel()
    ..id = json['id'] as String
    ..acnumber = json['acnumber'] as String
    ..name = json['name'] as String
    ..id_number = json['id_number'] as String;
}

Map<String, dynamic> _$SearchRespJModelToJson(SearchRespJModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'acnumber': instance.acnumber,
      'name': instance.name,
      'id_number': instance.id_number,
    };
