import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:vision_agency/screens/widgets/WithdrawalConfigure.dart';
//import 'dart:convert';
import 'package:sweetalert/sweetalert.dart';
import 'package:vision_agency/screens/shared/search.dart';
import 'package:vision_agency/screens/widgets/opt.dart';

//Deposits
///////////////////////////
class _WithdrawalState extends State<Withdrawal> with WidgetsBindingObserver {
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

class UserActions extends StatefulWidget {
  UserActions() : super();
  final String title = 'withdrawal';
  @override
  WithdrawalState createState() => WithdrawalState();
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

/////////////////////////////////////////////////////////////////////////////////////////////////
//Self Account Transfer
class Withdrawal extends StatefulWidget {
  @override
  WithdrawalState createState() => WithdrawalState();
}

class WithdrawalState extends State<Withdrawal> {
  List<Transact>_transact;
  GlobalKey<ScaffoldState> _scaffoldKey;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FocusNode _focusNodeAmount = new FocusNode();
  FocusNode _focusNodeNumber = new FocusNode();
  FocusNode _focusNodeUserPass = new FocusNode();
  FocusNode _focusNodeAgentPass = new FocusNode();


  TextEditingController number = new TextEditingController();
  TextEditingController amount = new TextEditingController();
  TextEditingController userPass = new TextEditingController();
  TextEditingController agentPass = new TextEditingController();


  String msg='';
  String drdropdownValue = 'Member Deposit';
  String crdropdownValue = 'Member Deposit';

  String  _reference;
  String _username;
  DateTime _dateTime = new DateTime.now();
  String urlPDFPath ="";
  bool _isLoading = true;
  PDFDocument doc;
  String opt;
  String phone;
  String prefix;
  String accountNumber;
  String account1;
  String lastPrefix;
  String memberNumber;
  String description;
  ///initial local variable//////////////////////////
  @override
  void initState() {
    super.initState();
    _transact =[];
    _scaffoldKey = GlobalKey();
    _getTransact();
    _reference = randomString(10);
    _username ='Admin';
    opt = randomString(4);
    phone = '0710707169';
    prefix = '400502';
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

    if(number.text.isEmpty||userPass.text.isEmpty||amount.text.isEmpty||agentPass.text.isEmpty) {
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
    crdropdownValue = 'CASH WITHDRAWAL';

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
    agentPass.text = '';
    userPass.text ='';
  }

  ///Opt function
  _addOpt(){
    account1 = number.text;
    memberNumber = (account1.toString().padLeft(10, '0'));

    OptConfiguration.addOpt(memberNumber, phone, opt, _dateTime.toString())
        .then((results){
    });
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('CASH WITHDRAWAL', style: TextStyle(color:Colors.white),),
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
//                      hintText: '12345',
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
                const SizedBox(height: 20.0),
                //////////////////////////////
                Container(
                  padding: EdgeInsets.only(left: 0.0),
                  width: double.infinity,
                  height: 25.0,
                  child: Text("Amount to Withdraw:", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0,),),
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
                    onTap:(){
                      setState(() {
                        _addOpt();
                      });
                    },
                  ),
                ),
                const SizedBox(height: 15.0),

                Container(
                  padding: EdgeInsets.only(left: 0.0),
                  width: double.infinity,
                  height: 25.0,
                  child: Text("Member Password:", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0,),),
                ),
                const SizedBox(height: 7.0),

                /* -- User Password -- */
                new EnsureVisibleWhenFocused(
                  focusNode: _focusNodeUserPass,
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
                    controller: userPass,
                    focusNode: _focusNodeUserPass,
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

                /* -- Agent Password -- */
                new EnsureVisibleWhenFocused(
                  focusNode: _focusNodeAgentPass,
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
                    controller: agentPass,
                    focusNode: _focusNodeAgentPass,
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
                      child: const Text("Withdraw",style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white ),),
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



