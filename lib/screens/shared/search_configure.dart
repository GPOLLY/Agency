import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)

class Search{
  String acNumber;
  String name;


  Search({this.acNumber, this.name});

  factory Search.fromJson(Map<String, dynamic>json){
    return Search(
      acNumber:json['acnumber'] as String,
      name:json['name'] as String,
    );
  }
  @override
  String toString() {
    return '{${this.name},${this.acNumber}}';
  }
}

