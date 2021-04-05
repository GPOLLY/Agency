import 'package:flutter/material.dart';
import 'package:vision_agency/screens/authenticate/login.dart';
import 'package:vision_agency/screens/home/home.dart';


class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Card topArea() => Card(
    margin: EdgeInsets.all(10.0),
    elevation: 1.0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50.0))),
    child: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                   // colors: [Color(0xFF015FFF), Color(0xFF015FFF)]
            )
        ),
        padding: EdgeInsets.all(5.0),
        // color: Color(0xFF015FFF),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                Text("Withdrawable Savings",
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(r"Kshs 95,940.00",
                    style: TextStyle(color: Colors.white, fontSize: 24.0)),
              ),
            ),
            SizedBox(height: 35.0),
          ],
        )),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//        drawer: AppDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.green,
          elevation: 0.0,
          title: Text(
            "Accounts Balance",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.black,
              ),
              onPressed: () {

              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                topArea(),
//                SizedBox(
//                  height: 40.0,
//                  child: Icon(
//                    Icons.refresh,
//                    size: 35.0,
//                    color: Color(0xFF015FFF),
//                  ),
//                ),
                displayAccoutList(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  padding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                  color: Color(0xFFF44336),
                  // borderSide: BorderSide(color: Color(0xFF015FFF), width: 1.0),
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: Text("PRINT"),
                ),
//                OutlineButton(
//                  padding:
//                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(0.0)),
//                  color: Color(0xFFF44336),
//                  borderSide: BorderSide(color: Color(0xFF015FFF), width: 1.0),
//                  onPressed: () {
//                    Navigator.of(context)
//                        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
//                      return new Login();}));
//
//                  },
//                  child: Text("CLOSE"),
//                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Container accountItems(
      String item, String charge, String dateString, String type,
      {Color oddColour = Colors.white}) =>
      Container(
        decoration: BoxDecoration(color: oddColour),
        padding:
        EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item, style: TextStyle(fontSize: 16.0)),
                Text(charge, style: TextStyle(fontSize: 16.0))
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(dateString,
                    style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                Text(type, style: TextStyle(color: Colors.grey, fontSize: 14.0))
              ],
            ),
          ],
        ),
      );

  displayAccoutList() {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          accountItems("Member Deposit", r"Kshs 4,946.00", "28-04-2020", "credit",
              oddColour: const Color(0xFFF7F7F9)),
          accountItems(
              "Member shares", r"Kshs 5,428.00", "26-04-2020", "credit"),
          accountItems("Normal Loan", r"kshs 746.00", "25-04-2020", "Payment",
              oddColour: const Color(0xFFF7F7F9)),
          accountItems(
              "School fees Loan", r"Kshs 14,526.00", "16-04-2020", "Payment"),
          accountItems(
              "Emergency Loan", r"Ksh 2,876.00", "04-04-2020", "Credit",
              oddColour: const Color(0xFFF7F7F9)),
        ],
      ),
    );
  }
}
