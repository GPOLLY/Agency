import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vision_agency/screens/shared/search_configure.dart';
import 'package:vision_agency/models/jsonserializable/api/from/SearchRespJModel.dart';
//import 'package:vision_agency/screens/shared/search_configure.dart';
//import 'package:json_serializable/json_serializable.dart';


class SearchMemberDetails extends StatefulWidget {
  @override
  _SearchMemberDetailsState createState() => _SearchMemberDetailsState();
}

class _SearchMemberDetailsState extends State<SearchMemberDetails> {
  TextEditingController searchValue = new TextEditingController();
  String _textResult = '';
  String names;
  String number;
  String name;
  Map data;
  List userData;
  int index;
  String names1;
  String number1;


  // ignore: missing_return
  Future<List<Search>> getData() async {
    var url = 'http://realtimetechnology.co.ke/agency/search.php';
    var response = await http.get(url);
    var notes = List<Search>();

    if (response.statusCode == 200){
      var searchData = json.decode(response.body);
      print(searchData.toString());

      List<SearchRespJModel> search = (response.body as List)
          .map((i) => SearchRespJModel.fromJson(i))
          .toList();

      setState(() {
        names1 = search[0].name;
      });

      print(names1);

}
    return notes;
  }



  ///assignment of the variable
  @override
  void initState() {
    super.initState();
    getData();
    names = 'BERNARD THEURI';
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('VISION AFRIKA SACCO', style: TextStyle(color:Colors.white),),
        centerTitle: true,
      ),
      body: Column(

        children: <Widget>[
          ////////
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 600.0,
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(top: 0.0, right: 10.0, left: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Search Member Details',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 0.0,
            color: Theme.of(context).primaryColor,
          ),

          Container(
            height: 2.0,
            color: Colors.white,
          ),
          ////
          //GridView Start
          SafeArea(
            top: false,
            bottom: false,
            child: new SingleChildScrollView(
              child: Container(
                width: double.infinity,
                color: Colors.white,
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 5.0),
            width: double.infinity,
            height: 500.0,
            color: Theme.of(context).primaryColor,

            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.all(3.0),
                  alignment: Alignment.center,
                  child: new Column(
                    children: <Widget>[
                      new Padding(padding: new EdgeInsets.only(top: 10.0, left: 0.0)),
                      new Text(
                        searchValue.text.isEmpty ? 'Please Enter ID Number' : _textResult,
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      ///////////////////////////////

                      Container(
                        width: 250.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        margin: EdgeInsets.all(12),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            new Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "",
                                  hintStyle: TextStyle(color: Colors.white),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  isDense: true,
                                ),
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      /* -- Search Button -- */
                      new Center(
                        child: Container(
                          width: 100.0,
                          height: 45.0,
                          child: new RaisedButton(
                            color: Colors.red,
                            child: const Text("Search",style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white ),),
                            onPressed: () {
                              getData();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.only(left: 0.0),
                  width: double.infinity,
                  height: 25.0,
                  child: Text("Member Details:", style: TextStyle( fontWeight: FontWeight.normal, color: Colors.yellowAccent, fontSize: 20.0,),),
                ),
                const SizedBox(height: 7.0),
                Container(
                  width: double.infinity,
                  height: 40.0,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.0, right: 10.0, left: 10.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(

                          child: Text('$names',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Container(
                  padding: EdgeInsets.only(left: 0.0),
                  width: double.infinity,
                  height: 25.0,
                  child: Text("Member Number:", style: TextStyle( fontWeight: FontWeight.normal, color: Colors.yellowAccent, fontSize: 20.0,),),
                ),
                const SizedBox(height: 7.0),
                Container(
                  width: double.infinity,
                  height: 40.0,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.0, right: 10.0, left: 10.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text('MEMBER NUMBER: 15609',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}

