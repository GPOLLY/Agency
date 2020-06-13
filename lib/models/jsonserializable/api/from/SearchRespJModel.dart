import 'package:json_annotation/json_annotation.dart';
part 'SearchRespJModel.g.dart';

@JsonSerializable()

class SearchRespJModel {
  String id;
  String acnumber;
  String name;
  String id_number;


  SearchRespJModel() {}
  SearchRespJModel.fromId(this.id) {}
  factory SearchRespJModel.fromJson(Map<String, dynamic> json) =>
      _$SearchRespJModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchRespJModelToJson(this);
}
