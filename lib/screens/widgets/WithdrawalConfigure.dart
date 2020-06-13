import 'dart:convert';
import 'package:http/http.dart' as http;


///Declare of the variables
class Transact{
  String account;
  String product;
  String amount;
  String password;
  String date;
  String reference;
  String username;

  Transact({this.account, this.product, this.amount,this.password,this.date,this.reference, this.username});

  factory Transact.fromJson(Map<String, dynamic>json){
    return Transact(
      account:json['account'] as String,
      product:json['product'] as String,
      amount:json['amount'] as String,
      password:json['password'] as String,
      date:json['date'] as String,
      reference:json['reference'] as String,
      username:json['username'] as String,

    );

  }

}
///End of the Declaration Variables
///

class TransactConfigure{
  static const ROOT = 'http://realtimetechnology.co.ke/agency/transact.php';
  //  public static final String URL_LOGIN = "http://10.0.3.2/work/login.php";
  static const _GET_JSON_ACTION = 'GET_JSON';
  static const _ADD_TRANSACT_ACTION = 'ADD_TRANSACT';


  //  get the list of the data from the table
  static Future<List<Transact>> getTransact() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_JSON_ACTION;
      final response = await http.post(ROOT, body: map);
      print('getTransact Response:${response.body}');

      if (200 == response.statusCode) {
        List<Transact> list = parseResponse(response.body);
        return list;
      } else {
        return List<Transact>();
      }
    } catch (e) {
      return List<Transact>();
    }
  }

  static List<Transact> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Transact>((json) => Transact.fromJson(json)).toList();
  }


//  method of add data into th database
  static Future<String> addTransact(String account, String amount, String product, String date, String reference, String username, String description) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_TRANSACT_ACTION;
      map['acnumber'] = account;
      map['amount'] = amount;
      map['product'] = product;
      map['date_t'] = date;
      map['reference'] = reference;
      map['username'] = username;
      map['description'] = description;

      final response = await http.post(ROOT, body: map);
      print('addTransact Response:${response.body}');



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