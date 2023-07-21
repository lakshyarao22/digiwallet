import 'package:digital_wallet/Widgets/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionStatus extends StatefulWidget {

  final String transactionID;

  TransactionStatus({Key key, @required this.transactionID}): super(key: key);

  @override
  _TransactionStatusState createState() => _TransactionStatusState(transactionID);
}

class _TransactionStatusState extends State<TransactionStatus> {

  String transactionID;
  _TransactionStatusState(this.transactionID);

  String _tranStatusImg = 'assets/Images/tran_success.png';
  String _tranStatusText = 'Transaction Successful';
  Color _tranStatusColor = Color(0xFF63C47B);
  int _tranStatusIconCode = 58956;
  Color _transFinishButtonColor = Color(0xFF63C47B);

  @override
  void initState() {
    if(transactionID != null) {
      _tranStatusImg = 'assets/Images/tran_success.png';
      _tranStatusText = 'Transaction Successful';
      _tranStatusColor = Color(0xFF63C47B);
      _tranStatusIconCode = 58956;
    }
    else {
      _tranStatusImg = 'assets/Images/tran_failed.png';
      _tranStatusText = 'Transaction Failed';
      _tranStatusColor = Colors.red;
      _tranStatusIconCode = 58972;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bgColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 16),
                alignment: FractionalOffset.topCenter,
                child: Text('Transaction Status', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              Container(
                alignment: FractionalOffset.center,
                child: Image.asset(_tranStatusImg, width: 200, height: 200,),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: _tranStatusColor,
                      child: Icon(IconData(_tranStatusIconCode, fontFamily: 'MaterialIcons'), color: Colors.white, size: 18,),
                    ),
                    Text(_tranStatusText, style: TextStyle(color: CupertinoColors.black, fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Transaction ID', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(transactionID, style: TextStyle(color: greyTextColor),)
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 24),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: GestureDetector(onTap: () {},child: Text('View Transaction Details', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),)),
                    ),
                  ],
                ),
              ),
              Spacer(),
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
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        return _transFinishButtonColor;
                      },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: _transFinishButtonColor))),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                    },
                    child: Container(margin: EdgeInsets.symmetric(vertical: 15,),
                        child: Text('Finish', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
