import 'dart:convert';

import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:digital_wallet/Widgets/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../global-variables.dart';

class TransactionDetails extends StatefulWidget {

  final String transactionID;

  TransactionDetails({Key key, @required this.transactionID}) : super(key: key);

  @override
  _TransactionDetailsState createState() => _TransactionDetailsState(transactionID);
}

class _TransactionDetailsState extends State<TransactionDetails> {

  String transactionID;
  _TransactionDetailsState(this.transactionID);

  String amount = '-- --', partner = '--', wallet = '--', number = '--', timestamp = '--', status = '--';
  Color statusColor = Colors.green;

  ProgressDialog _progressDialog = ProgressDialog();

  @override
  void initState() {
    _getTransactionDetail();
    super.initState();
  }

  void _getTransactionDetail() async {

    _progressDialog.showProgressDialog(context);

    var queryParameters = {
      'mobileNumber': NUMBER,
      'transactionID': transactionID
    };

    var uri = Uri.http(backendURL, '/api/transactions/fetch.php', queryParameters);

    var response = await http.get(uri);
    String serverResponse = response.body;

    var jsonData = jsonDecode(serverResponse)[0];

    setState(() {
      amount = jsonData['amount'];
      partner = jsonData['partner'];
      wallet = jsonData['wallet'];
      number = jsonData['number'];
      timestamp = jsonData['timestamp'];
      status = jsonData['status'];
      if(!status.contains('Successful')) {
        statusColor = Colors.red;
      }
      else {
        statusColor = Colors.green;
      }
    });

    _progressDialog.dismissProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(top: 16),
                alignment: FractionalOffset.topCenter,
                child: Text('Transaction Details', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('$amount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Container(margin: EdgeInsets.only(top: 10), child: Text('$status Transaction', style: TextStyle(fontSize: 12, color: statusColor),))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Align(alignment: Alignment.topLeft, child: Text('Transaction Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Partner', style: TextStyle(fontSize: 14)),
                          Text('$partner', style: TextStyle(fontSize: 14, color: greyTextColor)),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Wallet', style: TextStyle(fontSize: 14)),
                          Text('$wallet', style: TextStyle(fontSize: 14, color: greyTextColor)),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Phone Number', style: TextStyle(fontSize: 14)),
                          Text('$number', style: TextStyle(fontSize: 14, color: greyTextColor)),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Transaction ID', style: TextStyle(fontSize: 14)),
                          Text(transactionID, style: TextStyle(fontSize: 14, color: greyTextColor)),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Transaction Time', style: TextStyle(fontSize: 14)),
                          Text('$timestamp', style: TextStyle(fontSize: 14, color: greyTextColor)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Align(alignment: Alignment.topLeft, child: Text('Billing Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Amount', style: TextStyle(fontSize: 14)),
                          Text('$amount'.split(" ")[1], style: TextStyle(fontSize: 14, color: greyTextColor)),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Fee', style: TextStyle(fontSize: 14)),
                          Text('Free', style: TextStyle(fontSize: 14, color: greyTextColor)),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Payment', style: TextStyle(fontSize: 14)),
                          Text('$amount'.split(" ")[1], style: TextStyle(fontSize: 14, color: greyTextColor)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/Images/c_support.png', width: 24, height: 24,),
                    RichText(text: TextSpan(text: 'Contact Customer Service - ', style: TextStyle(fontSize: 12, color: Color(0xFF718096), fontFamily: 'Kodchasan',),
                      children: <TextSpan>[
                        TextSpan(text: '1-800-433-7330', style: TextStyle(fontSize: 12, color: primaryColor, fontFamily: 'Kodchasan', fontWeight: FontWeight.bold),),
                      ],
                    ),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
