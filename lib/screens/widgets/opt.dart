import 'package:http/http.dart' as http;

class VariableOpt{
  String memberNumber;
  String phone;
  String msg;
  String date;

  VariableOpt({this.memberNumber, this.phone, this.msg, this.date});

  factory VariableOpt.fromJson(Map<String, dynamic>json){
    return VariableOpt(
      memberNumber:json['memberNumber'] as String,
      phone:json['phone'] as String,
      msg:json['msg'] as String,
      date:json['date'] as String,
    );
  }

}

class OptConfiguration{
  static const ROOT =  'http://realtimetechnology.co.ke/agency/Opt.php';
  static const _ADD_OPT_ACTION = 'ADD_OPT';

  ///  method of add data into th database
  static Future<String> addOpt(String memberNumber, String phone, String msg, String date) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_OPT_ACTION;
      map['acnumber'] = memberNumber;
      map['phone'] = phone;
      map['msg'] = msg;
      map['date_t'] = date;

      final response = await http.post(ROOT, body: map);
      print('addOpt Response:${response.body}');


      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

}