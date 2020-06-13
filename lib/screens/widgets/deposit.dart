import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:sweetalert/sweetalert.dart';
import 'dart:math';
import 'dart:core';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:vision_agency/screens/shared/search.dart';
import 'package:vision_agency/screens/widgets/transact_configure.dart';

//Deposits
///////////////////////////
class _MemberDepositsState extends State<MemberDeposits> with WidgetsBindingObserver {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //This routine is invoked when the window metrics have changed.

  @override
  void didChangeMetrics(){

  }

  @override
  Widget build(BuildContext context) {

    return null;
  }

}


class EnsureVisibleWhenFocused extends StatefulWidget {
  const EnsureVisibleWhenFocused({
    Key key,
    @required this.child,
    @required this.focusNode,
    this.curve: Curves.ease,
    this.duration: const Duration(milliseconds: 100),
  }) : super(key: key);

  /// The node we will monitor to determine if the child is focused
  final FocusNode focusNode;

  /// The child widget that we are wrapping
  final Widget child;

  /// The curve we will use to scroll ourselves into view.
  ///
  /// Defaults to Curves.ease.
  final Curve curve;

  /// The duration we will use to scroll ourselves into view
  ///
  /// Defaults to 100 milliseconds.
  final Duration duration;

  @override
  _EnsureVisibleWhenFocusedState createState() => new _EnsureVisibleWhenFocusedState();
}

///
/// We implement the WidgetsBindingObserver to be notified of any change to the window metrics
///
class _EnsureVisibleWhenFocusedState extends State<EnsureVisibleWhenFocused> with WidgetsBindingObserver  {

  @override
  void initState(){
    super.initState();
    widget.focusNode.addListener(_ensureVisible);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    widget.focusNode.removeListener(_ensureVisible);
    super.dispose();
  }


  @override
  void didChangeMetrics(){
    if (widget.focusNode.hasFocus){
      _ensureVisible();
    }
  }


  Future<Null> _keyboardToggled() async {
    if (mounted){
      EdgeInsets edgeInsets = MediaQuery.of(context).viewInsets;
      while (mounted && MediaQuery.of(context).viewInsets == edgeInsets) {
        await new Future.delayed(const Duration(milliseconds: 10));
      }
    }

    return;
  }

  Future<Null> _ensureVisible() async {
    // Wait for the keyboard to come into view
    await Future.any([new Future.delayed(const Duration(milliseconds: 300)), _keyboardToggled()]);

    // No need to go any further if the node has not the focus
    if (!widget.focusNode.hasFocus){
      return;
    }

    // Find the object which has the focus
    final RenderObject object = context.findRenderObject();
    final RenderAbstractViewport viewport = RenderAbstractViewport.of(object);

    // If we are not working in a Scrollable, skip this routine
    if (viewport == null) {
      return;
    }

    // Get the Scrollable state (in order to retrieve its offset)
    ScrollableState scrollableState = Scrollable.of(context);
    assert(scrollableState != null);

    // Get its offset
    ScrollPosition position = scrollableState.position;
    double alignment;

    if (position.pixels > viewport.getOffsetToReveal(object, 0.0).offset) {
      // Move down to the top of the viewport
      alignment = 0.0;
    } else if (position.pixels < viewport.getOffsetToReveal(object, 1.0).offset){
      // Move up to the bottom of the viewport
      alignment = 1.0;
    } else {
      // No scrolling is necessary to reveal the child
      return;
    }

    position.ensureVisible(
      object,
      alignment: alignment,
      duration: widget.duration,
      curve: widget.curve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
///This is the Random ref auto generating code
const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
String randomString(int strlen) {
  Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < strlen; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result;
}
///end of the Random number auto generating code ////////
///
class UserActions extends StatefulWidget {
  UserActions() : super();
  final String title = 'Deposits';
  @override
  MemberDepositsState createState() => MemberDepositsState();
}

/////////////////////////////////////////////////////////////////////////////////////////////////
//Self Account Transfer
class MemberDeposits extends StatefulWidget {
  @override
  MemberDepositsState createState() => MemberDepositsState();
}

class MemberDepositsState extends State<MemberDeposits> {
  List<Transact>_transact;
  GlobalKey<ScaffoldState> _scaffoldKey;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FocusNode _focusNodeAmount = new FocusNode();
  FocusNode _focusNodeNumber = new FocusNode();
  FocusNode _focusNodePassword = new FocusNode();

  TextEditingController number = new TextEditingController();
  TextEditingController amount = new TextEditingController();
  TextEditingController password = new TextEditingController();

  ///Declare the instant variable
  String msg='';
  String drdropdownValue = 'Member Deposit';
  String crdropdownValue = 'Member Deposit';

  String  _reference;
  String _username;
  DateTime _dateTime = new DateTime.now();
  String urlPDFPath ="";
  bool _isLoading = true;
  PDFDocument doc;
  String username;
  String prefix;
  String accountNumber;
  String account1;
  String lastPrefix;
  String memberNumber;
  String description;

  ///assigning the local varibles
  @override
  void initState() {
    super.initState();

    _transact =[];
    _scaffoldKey = GlobalKey();
    _getTransact();
    _reference = randomString(10);
    _username = 'Admin';
    prefix = '400620';
    lastPrefix = '00';

    _isLoading
        ? CircularProgressIndicator()
        : PDFViewer(
      document: doc,
    );
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }


  ///insert into the database
  ///First let us check if all the required fields are filled
  _addTransact(){

    if(number.text.isEmpty||crdropdownValue.isEmpty||amount.text.isEmpty||password.text.isEmpty) {
      SweetAlert.show(context, title: "Please Enter The Entire Data");
      _clearValues();
      return;
    }

    ///Begin Constructor account number
    account1 = number.text;
    memberNumber = (account1.toString().padLeft(10, '0'));
    accountNumber = '$prefix$memberNumber$lastPrefix';
    ///end of the Constructor of account number

    ///Description
    description = 'PAYMENT OF '+ crdropdownValue;


    TransactConfigure.addTransact(accountNumber, amount.text, crdropdownValue, _dateTime.toString(),_reference.toString(), _username, description)
        .then((result){
      if('success' ==result) {
        SweetAlert.show(context, title: "Save Successfully");
        _showSnackBar(context, result);

      }
      else{
        SweetAlert.show(context, title: "Save Not Successfully");
        result ='Error';
        _showSnackBar(context, result);

      }
    });
  }

  _getTransact(){
//    _showProgress('Please wait!!!!!....');
    TransactConfigure.getTransact().then((results){
      setState(() {
        _transact = _transact;
      });
//      _showProgress(widget.title);
      print("Length ${_transact.length}");
    });
  }

  ///method of clear the TextField
  _clearValues() {
    number.text = '';
    amount.text = '';
    crdropdownValue = '';
    password.text ='';
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('MEMBER DEPOSITS', style: TextStyle(color:Colors.white),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search, size: 30.0,),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchMemberDetails()),
                );
              })
        ],
      ),
      //drawer: Drawer(),

      body: new SafeArea(
        top: false,
        bottom: false,

        child: new Form(
          key: _formKey,
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),

            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 15.0,
                ),
                /* -- Something large -- */
                Container(
                  padding: EdgeInsets.only(left: 0.0),
                  width: double.infinity,
                  height: 25.0,
                  child: Text("Member Number:", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0,),),
                ),
                const SizedBox(height: 15.0),

                /* -- Member Number -- */
                new EnsureVisibleWhenFocused(
                  focusNode: _focusNodeNumber,
                  child: new TextFormField(
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      labelText: 'Member Number *',
                    ),
                    onSaved: (String value) {

                    },
                    controller: number,
                    focusNode: _focusNodeNumber,
                  ),
                ),
                const SizedBox(height: 15.0),

                Container(
                  padding: EdgeInsets.only(left: 0.0),
                  width: double.infinity,
                  height: 25.0,
                  child: Text("Member Name:", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0,),),
                ),
                const SizedBox(height: 15.0),
                Container(
                  padding: EdgeInsets.only(left: 5.0, top: 7.0),
                  width: 400.0,
                  height: 40.0,
                  color: Theme.of(context).primaryColor,
                  child: Text('BERNARD THEURI',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22.0,
                      letterSpacing: 1.0,
                    ),
                  ),

                ),
                const SizedBox(height: 15.0),
                //////////////////////////////
                Container(
                  height: 30.0,
                ),
                /* -- Something large -- */
                Container(
                  padding: EdgeInsets.only(left: 0.0),
                  width: double.infinity,
                  height: 25.0,
                  child: Text("Select a Product:", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0,),),
                ),
                const SizedBox(height: 15.0),
                ///Drop downButton
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.cyan,
                  ),
                  child: Container(
                    ////////////
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.0, style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    child:  DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          value: crdropdownValue,
                          iconSize: 40,
                          elevation: 16,
                          style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.normal, color: Colors.black, fontSize: 20.0,),
                          onChanged: (String newValue) {
                            setState(() {
                              crdropdownValue = newValue;
                            });
                          },
                          items: <String>['Member Deposit', 'Share Capital', 'Normal Loan', 'School fees Loan']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                ////////////////////////
                Container(
                  height: 50.0,
                ),
                /* -- Something large -- */
                Container(
                  padding: EdgeInsets.only(left: 0.0),
                  width: double.infinity,
                  height: 25.0,
                  child: Text("Amount to Deposit:", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0,),),
                ),
                const SizedBox(height: 7.0),

                /* -- Amount -- */
                new EnsureVisibleWhenFocused(
                  focusNode: _focusNodeAmount,
                  child: new TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
//                      hintText: '[1 - 9]',
                      labelText: 'Amount *',
                    ),
                    onSaved: (String value) {

                    },
                    controller: amount,
                    focusNode: _focusNodeAmount,
                  ),
                ),
                const SizedBox(height: 15.0),

                Container(
                  padding: EdgeInsets.only(left: 0.0),
                  width: double.infinity,
                  height: 25.0,
                  child: Text("Agent Password:", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0,),),
                ),
                const SizedBox(height: 7.0),

                /* -- Remarks -- */
                new EnsureVisibleWhenFocused(
                  focusNode: _focusNodePassword,
                  child: new TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      filled: true,
                      hintText: '******',
                      labelText: 'Password *',
                    ),
                    onSaved: (String value) {

                    },
                    controller: password,
                    focusNode: _focusNodePassword,
                  ),
                ),
                const SizedBox(height: 20.0),


                /* -- Save Button -- */
                new Center(
                  child: Container(
                    width: 200.0,
                    height: 45.0,
                    child: new RaisedButton(
                      color: Colors.red,
                      child: const Text("Save",style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white ),),
                      onPressed: () {
                        _addTransact();
                        _clearValues();
                      },
                    ),
                  ),
                ),
                //const SizedBox(height: 14.0),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
//End of Deposit
/////////////////////////////////////////////////////////////////////////////////////////////////



