import 'dart:convert';
import 'dart:ui';

import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/currency_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:digital_wallet/Dashboard/Home/transfer.dart';
import 'package:digital_wallet/Widgets/Color.dart';
import 'package:digital_wallet/global-variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:digital_wallet/Dashboard/Home/transaction-status.dart';

class ConfirmTransfer extends StatefulWidget {

  final RecipientItem recipientItem;

  ConfirmTransfer({Key key, @required this.recipientItem}) : super(key: key);

  @override
  _ConfirmTransferState createState() => _ConfirmTransferState(recipientItem);
}

class _ConfirmTransferState extends State<ConfirmTransfer> {

  final controller = TextEditingController();
  final PanelController _pc = PanelController();

  String cSymbol = SYMBOL;
  String cCode = CURRENCY_CODE;
  String cBalance = BALANCE;
  bool enoughMoney = false;

  Color balanceColor = Colors.green;

  ProgressDialog _progressDialog = ProgressDialog();

  RecipientItem recipientItem;
  _ConfirmTransferState(this.recipientItem);

  bool _showTB = true;
  bool _showLoader = false;
  bool _isButtonDisabled = false;

  Widget _buildCurrencyDropdownItem(Country country) => Container(
    child: Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(
          width: 8.0,
        ),
        Text("${country.currencyCode}"),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        if(_pc.isPanelOpen) {
          _pc.close();
          return false;
        }
        else {
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bgColor,
        body: SafeArea(
          child: SlidingUpPanel(
            controller: _pc,
            backdropEnabled: true,
            color: Colors.transparent,
            maxHeight: 390,
            minHeight: 0,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(recipientItem.image),),
                    title: Text(recipientItem.name, style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text(recipientItem.number),
                  ),
                  Container(
                    alignment: FractionalOffset.centerLeft,
                    margin: EdgeInsets.only(top: 16, left: 16),
                      child: Text('Enter Amount', style: TextStyle(color: CupertinoColors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    margin: EdgeInsets.only(top: 60, left: 16, right: 16),
                    padding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('$cSymbol', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFeatures: [FontFeature.enable('sups')]),),
                            SizedBox(
                              width: 100,
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: TextField(
                                    controller: controller,
                                    onChanged: _changeBalanceColor ,
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Amount',
                                        hintStyle: TextStyle(
                                            color: Color(0xFFCBD5E0)
                                        ),
                                    )
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CurrencyPickerDropdown(
                                initialValue: CURRENCY_CODE,
                                itemBuilder: _buildCurrencyDropdownItem,
                                onValuePicked: (Country country) {
                                  setState(() {
                                    cCode = country.currencyCode;
                                  });
                                  _getCurrencyBalance();
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Center(
                            child: Text('You have $cBalance $cCode in your wallet', style: TextStyle(color: balanceColor),),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 16),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: double.infinity),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: primaryColor)))),
                                child: Container(margin: EdgeInsets.symmetric(vertical: 15,),
                                    child: Text('Transfer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                              onPressed: () {
                                  if(enoughMoney) {
                                    if(int.parse(controller.text) == 0) {
                                      Fluttertoast.showToast(
                                          msg: 'Minimum amount is '+cSymbol+'1',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                    }
                                    else {
                                      _pc.open();
                                    }
                                  }
                                  else {
                                    if(controller.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: 'Amount can\'t be empty',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                    }
                                    else {
                                      return showDialog(context: context, builder: (context) {
                                        return AlertDialog(
                                          title: Text('Top Up', style: TextStyle(fontWeight: FontWeight.bold),),
                                          content: Text('You don\'t have enough $cCode. Please top up or convert one currency to $cCode'),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel', style: TextStyle(color: Colors.red),)
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Convert', style: TextStyle(color: Colors.green),)
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Top-Up')),
                                          ],
                                        );
                                      });
                                    }
                                  }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            panel: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 170.0),
                    padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Confirm Transfer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    ),
                  ),
                  Container(
                    alignment: FractionalOffset.centerLeft,
                    margin: EdgeInsets.only(top: 20, left: 10),
                    padding: EdgeInsets.only(top: 16, bottom: 16, left: 10, right: 16),
                    child: Text('$cSymbol '+controller.text, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    alignment: FractionalOffset.centerLeft,
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Send money to '+recipientItem.name, style: TextStyle(color: greyTextColor, fontSize: 14),),
                  ),
                  Container(
                    alignment: FractionalOffset.centerLeft,
                    margin: EdgeInsets.only(top: 16),
                    child: ListTile(
                      leading: Image.asset('assets/Images/wallet.png'),
                      title: Text('Afriiqpay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      subtitle: Text('Wallet balance: $cSymbol $cBalance', style: TextStyle(fontSize: 14),),
                    ),
                  ),
                  Container(
                    alignment: FractionalOffset.centerLeft,
                    margin: EdgeInsets.only(top: 30, left: 26, right: 26),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                                child: Text('Total', style: TextStyle(color: greyTextColor, fontSize: 14),)
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(''
                                  '$cSymbol '+controller.text, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                    return Color(0xFF63C47B);
                                  },
                                ),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Color(0xFF63C47B))))),
                            child: Container(margin: EdgeInsets.symmetric(vertical: 15,),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Visibility(visible: _showTB, child: Image.asset('assets/Icons/Imageshield.png', fit: BoxFit.cover, height: 30, width: 30,)),
                                    Visibility(visible: _showLoader, child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)),
                                    Visibility(visible: _showTB, child: Text('Transfer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                                  ],
                                )),
                              onPressed: () => _isButtonDisabled ? null : _performTransaction(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: FractionalOffset.centerLeft,
                    margin: EdgeInsets.only(top: 30, left: 26, right: 26),
                    child: Row(
                      children: [
                        Image.asset('assets/Images/security.png'),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text('PCI-DSS Security Standards certificate', style: TextStyle(color: greyTextColor, fontSize: 12),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _performTransaction() async {
    setState(() {
      _isButtonDisabled = true;
      _showTB = false;
      _showLoader = true;
    });

    var url = Uri.http(backendURL, '/api/users/send.php');

    var data = new Map<String, String>();

    data['senderNumber'] = NUMBER;
    data['receiverNumber'] = recipientItem.number;
    data['currencyCode'] = cCode;
    data['currencySymbol'] = cSymbol;
    data['amount'] = controller.text;

    http.Response response = await http.post(url, body: data);

    var transactionID = jsonDecode(response.body)['transaction_id'];

    setState(() {
      _isButtonDisabled = false;
      _showTB = true;
      _showLoader = false;
    });

    Navigator.push(context, new MaterialPageRoute(builder: (context) => TransactionStatus(transactionID: transactionID,)));

  }

  _changeBalanceColor(String text) async {
    if(text.isNotEmpty) {
      if(int.parse(cBalance) < int.parse(text)) {
        balanceColor = Colors.red;
        enoughMoney = false;
      }
      else {
        balanceColor = Colors.green;
        enoughMoney = true;
      }
    }
    else {
      balanceColor = Colors.green;
      enoughMoney = true;
    }

    setState(() {
      balanceColor = balanceColor;
    });
  }

  void _getCurrencyBalance() async {

    _progressDialog.showProgressDialog(context);

    var queryParameters = {
      'mobileNumber': NUMBER,
      'currencyCode': cCode
    };

    var uri = Uri.http(backendURL, '/api/currencies/balance.php', queryParameters);

    var response = await http.get(uri);
    String serverResponse = response.body;

    Map<String, dynamic> map = jsonDecode(serverResponse);

    setState(() {
      cBalance = map['balance'].toString();
      cSymbol = map['symbol'];
    });

    _progressDialog.dismissProgressDialog(context);
  }
}

