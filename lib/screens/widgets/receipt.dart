import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';


class MemberReceipt extends StatefulWidget {
  @override
  _MemberReceipt createState() => _MemberReceipt();
}

class _MemberReceipt extends State<MemberReceipt> {
  PDFDocument doc;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  ///The Method below for picking URL Online
  void _loadFromUrl() async {
    setState(() {
      _isLoading = true;
    });
    doc = await PDFDocument.fromURL(
        'https://realtimetechnology.co.ke/agency/invoice.php');
    setState(() {
      _isLoading = false;
    });
  }
  ///end of the Above Method
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Member Receipt'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Flexible(
                flex: 8,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : PDFViewer(
                  document: doc,
                ),
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Print Member Receipt',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _loadFromUrl,
              ),

            ]
        ),
      ),


    );
  }

}


