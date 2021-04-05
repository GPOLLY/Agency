//import 'package:ajenti/screens/widgets/deposit.dart';
//import 'package:ajenti/screens/widgets/withdraw.dart';
import 'package:flutter/material.dart';
import 'package:vision_agency/screens/authenticate/login.dart';
import 'package:vision_agency/screens/shared/search.dart';
import 'package:vision_agency/screens/widgets/account_drawer.dart';
import 'package:vision_agency/screens/widgets/deposit.dart';
import 'package:vision_agency/screens/widgets/inquery.dart';
import 'package:vision_agency/screens/widgets/withdraw.dart';


class Home extends StatelessWidget {

  final agent;

  const Home({Key key, this.agent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('VISION  SACCO', style: TextStyle(color:Colors.black),),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.settings_power),
//              size: 35.0,
              onPressed: (){
                Navigator.of(context)
                  .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                return new Login();}));}

                ,),


        ],
      ),
//
      body: Column(
        children: <Widget>[
          ////////
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height  -600.0,
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(top: 0.0, right: 10.0, left: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Welcome '+ agent,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 23.0,

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
            height: 470.0,
            color: Theme.of(context).primaryColor,

            ///////////////////
            child: GridView.count(
              crossAxisCount: 2 ,
              childAspectRatio: 1.2,
              children: List.generate(6,(index){
                return Container(
                  child: Card(
                    color: Colors.white,
                    child: InkResponse(
                      child: Column(
                        children: [
                          Container(child: Image.network(tiles[index].imageUrl, fit: BoxFit.cover,), height: 30),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: Image.asset(tiles[index].imageUrl, fit: BoxFit.cover,), height: 50,
                          ),

                          Text((tiles[index].title), style: TextStyle(fontSize: 15, color: Colors.blueAccent, fontWeight: FontWeight.w500),),
                          Text((tiles[index].subtitle), style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400),),
                        ],
                      ),

                      onTap: (){
                        if(index == 0){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MemberDeposits()),
                          );
                        } else if(index == 1){ //
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Withdrawal()),
                          );
                        } else if(index == 2){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Account()),
                          );
                        } else if(index == 3){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SearchMemberDetails()),
                          );
                        } else if(index == 4){
                          // Navigator.push(context,
                          //   MaterialPageRoute(builder: (context) => Registration(stitle: tiles[index],)),
                          // );
                        } else if(index == 5){
                          // Navigator.push(context,
                          //   MaterialPageRoute(builder: (context) => AgentSetup(stitle: tiles[index],)),
                          // );
                        } else {
                          // Navigator.push(context,
                          //   MaterialPageRoute(builder: (context) => GridDetails(stitle: tiles[index],)),
                          // );
                        }

                        //print(index);
                      },
                    ),

                  ),
                );
              }),
            ),
            ///////////////////
          ),
        ],
      ),

    );
  }
}


List tiles = [
  TileInfo(
      imageUrl: "assets/images/menu/pic0.jpg",
      id: "0",
      title: "Cash",
      subtitle: "Deposits"),
  TileInfo(
      imageUrl: "assets/images/menu/pic1.jpg",
      id: "1",
      title: "Cash",
      subtitle: "Withdrawal"),
  TileInfo(
      imageUrl: "assets/images/menu/pic2.jpg",
      id: "2",
      title: "",
      subtitle: "Balance Check"),
  TileInfo(
      imageUrl: "assets/images/menu/pic3.jpg",
      id: "3",
      title: "",
      subtitle: "Search Customer"),
  TileInfo(
      imageUrl: "assets/images/menu/pic4.jpg",
      id: "4",
      title: "",
      subtitle: "Services"),
  TileInfo(
      imageUrl: "assets/images/menu/pic5.jpg",
      id: "5",
      title: "",
      subtitle: "Member Registration"),

];

class TileInfo {

  String imageUrl;
  String title;
  String subtitle;
  String id;

  TileInfo({this.imageUrl, this.title, this.subtitle, this.id});
}

class GridDetails extends StatelessWidget {

  final TileInfo stitle;

  GridDetails({this.stitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VISION AFRIKA SACCO', style: TextStyle(color:Colors.white),),
        centerTitle: true,
        actions: <Widget>[
          Icon(Icons.search,
            size: 35.0,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 680.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                //colors: ([Color.fromRGBO(118, 155, 207, 1),Color.fromRGBO(118, 155, 207, 1)]), //fromRGBO(132, 173, 231, 1)
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 0.0, right: 10.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(stitle.subtitle,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              width: double.infinity,
              height: 2.0
          ),
          Container(
            width: double.infinity,
            height: 545.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                //colors: ([Color.fromRGBO(118, 155, 207, 0.5),Color.fromRGBO(118, 155, 207, 0.5)]),
              ),
            ),
            child: Column(
              children: <Widget>[
                //SaccoFundsTransfer(),
                /*
                  Column(
                    children: [
                        if (_selectedIndex == 0) ...[
                          DayScreen(),
                        ] else if(_selectedIndex == 1)...[
                          StatsScreen(),
                        ],
                    ],
                  ),
                  */
              ],
            ),
          ),
          Container(
              width: double.infinity,
              height: 5.0
          ),
        ],
      ),
    );
  }
}

//START HERE
///////////////////////////////////////////////////////////
//Accounts
class Deposits extends StatelessWidget {

  final TileInfo stitle;

  Deposits({this.stitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VISION AFRIKA SACCO', style: TextStyle(color:Colors.white),),
        centerTitle: true,
        actions: <Widget>[
          Icon(Icons.search,
            size: 35.0,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 680.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                //colors: ([Color.fromRGBO(118, 155, 207, 1),Color.fromRGBO(118, 155, 207, 1)]), //fromRGBO(132, 173, 231, 1)
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 0.0, right: 10.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(stitle.subtitle,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              width: double.infinity,
              height: 2.0
          ),
          Container(
            width: double.infinity,

            child: Column(
              children: <Widget>[
                MemberDeposits(),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              height: 5.0
          ),

        ],
      ),
    );
  }
}


