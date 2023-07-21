import 'dart:convert';
import 'package:digital_wallet/Dashboard/Home/Discounts.dart';
import 'package:digital_wallet/Dashboard/Home/Recharge.dart';
import 'package:digital_wallet/Widgets/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:digital_wallet/Dashboard/Home/transfer.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:digital_wallet/Dashboard/Home/history.dart';
import '../../global-variables.dart';
import '../topUp.dart';
import 'package:permission_handler/permission_handler.dart';

class MainHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, screenType)
    {
      return MaterialApp(
        theme: ThemeData(fontFamily: 'Kodchasan'),
        initialRoute: '/',
        routes: {
          '/': (context) => BuildHome(),
          '/ConfirmTopUp': (context) => ConfirmTopup(),
          '/Transfer': (context) => Transfer(),
          '/History': (context) => History(),
          '/Mobile': (context) => Recharges(),
          '/Voucher': (context) => Discounts(),
        },
      );}
    );}
}


class BuildHome extends StatefulWidget {
  @override
  _BuildHomeState createState() => _BuildHomeState();
}

final PanelController _pc = PanelController();

class _BuildHomeState extends State<BuildHome> {

  RefreshController _refreshController = RefreshController(initialRefresh: true);

  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    fetchUserDetails();
    _refreshController.refreshCompleted();

  }
  bool textVisibility = true;
  bool textFieldVisibility = false;
void _textFieldButton(){
   setState(() {
     textVisibility = false;
     textFieldVisibility = true;
   });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      body: SafeArea(
        child: SmartRefresher(
          enablePullUp: false,
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: SlidingUpPanel(
              controller: _pc,
              backdropEnabled: true,
              color: Colors.transparent,
              minHeight: 0,
              body: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20.0, 30.0, 10.0, 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {

                                    },
                                    child: Text(
                                      'Search for everything...', style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {}, // handle your image tap here
                                    child: Image.asset(
                                      'assets/Icons/iconBell.png',
                                      fit: BoxFit.cover, // this is the solution for border
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.symmetric( horizontal: 20.0, vertical: 15.0),
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Balance',
                                      style: TextStyle(fontSize: 20),),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('$CURRENCY_CODE  '+'$BALANCE  ', style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color(0xFF63C47B))),
                                          Image.asset('assets/Icons/iconeyes.png', height: 30, width: 30,)
                                        ]
                                    )
                                  ],
                                )
                            ),


                            Container(
                              margin: EdgeInsets.symmetric( horizontal: 20.0, vertical: 15.0),
                              child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () => _pc.open(),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children:[
                                            Image.asset('assets/Icons/icontopup.png', height: 50, width: 50,),

                                            Text('Top Up'),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){

                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children:[
                                            Image.asset('assets/Icons/Imagewithdraw.png', height: 50, width: 50,),
                                            Text('Withdraw'),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: ()
                                          async {
                                            var status = await Permission.contacts.request();
                                            if (status.isGranted) {
                                              Navigator.pushNamed(context, '/Transfer');
                                            } else if (status.isDenied) {
                                              Navigator.pop(context);
                                            }
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children:[
                                            Image.asset('assets/Icons/iconTransfer.png', height: 50, width: 50,),
                                            Text('Transfer'),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pushNamed(context, '/History');
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children:[
                                            Image.asset('assets/Icons/Imagehistory.png', height: 50, width: 50,),
                                            Text('History'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric( horizontal: 20.0, vertical: 15.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 20.0 ,horizontal: 0.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children:[
                                                Image.asset('assets/Icons/iconGrocery.png', height: 50, width: 50,),
                                                Text('Grocery'),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){

                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children:[
                                                Image.asset('assets/Icons/iconShopping.png', height: 50, width: 50,),
                                                Text('Shopping'),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){

                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children:[
                                                Image.asset('assets/Icons/iconFood.png', height: 50, width: 50,),
                                                Text('Food'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: (){

                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, children:[
                                              Image.asset('assets/Icons/iconBarcode.png', height: 50, width: 50,),
                                              Text('Barcode'),],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.pushNamed(context, '/Voucher');

                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children:[
                                                Image.asset('assets/Icons/iconVoucher.png', height: 50, width: 50,),
                                                Text('Voucher'),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){

                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children:[
                                                Image.asset('assets/Icons/iconTicket.png', height: 50, width: 50,),
                                                Text('Ticket'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: (){

                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children:[
                                                Image.asset('assets/Icons/iconUtilities.png', height: 50, width: 50,),
                                                Text('Utilities'),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.pushNamed(context, '/Mobile');
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children:[
                                                Image.asset('assets/Icons/iconMobile.png', height: 50, width: 50,),
                                                Text('Mobile'),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){

                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children:[
                                                Image.asset('assets/Icons/iconFeatures.png', height: 50, width: 50,),
                                                Text('Features'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]
                      ),
                    )
                ),


              panel: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20), topRight: Radius.circular(20)
                    )
                ),
                child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 170.0),
                        padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Select Amount', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
                            ]),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0 ,horizontal: 0.0),
                        decoration: BoxDecoration(
                          color: Colors.white,

                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      TextButton(
                                          child: Text('2000'),
                                          onPressed: () {}),
                                      Icon(CupertinoIcons.money_dollar,
                                        color: Colors.greenAccent,)
                                    ],),
                                  Row(
                                    children: [
                                      TextButton(
                                          child: Text('1000'),
                                          onPressed: () {
                                            Navigator.pushNamed(context, '/ConfirmTopUp');
                                          }),
                                      Icon(CupertinoIcons.money_dollar,
                                        color: Colors.greenAccent,)
                                    ],),
                                  Row(
                                    children: [
                                      TextButton(
                                          child: Text('500' ),
                                          onPressed: () {}),
                                      Icon(CupertinoIcons.money_dollar,
                                        color: Colors.greenAccent,)
                                    ],),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      TextButton(
                                          child: Text('200' ),
                                          onPressed: () {}),
                                      Icon(CupertinoIcons.money_dollar,
                                        color: Colors.greenAccent,)
                                    ],),
                                  Row(
                                    children: [
                                      TextButton(
                                          child: Text('100' ),
                                          onPressed: () {}),
                                      Icon(CupertinoIcons.money_dollar,
                                        color: Colors.greenAccent,)
                                    ],),
                                  Row(
                                    children: [
                                      TextButton(
                                          child: Text('50' ),
                                          onPressed: () {}),
                                      Icon(CupertinoIcons.money_dollar,
                                        color: Colors.greenAccent,)
                                    ],),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      TextButton(
                                          child: Text('10' ),
                                          onPressed: () {}),
                                      Icon(CupertinoIcons.money_dollar,
                                        color: Colors.greenAccent,)
                                    ],),
                                  Row(
                                    children: [
                                      TextButton(
                                          child: Text('5' ),
                                          onPressed: () {}),
                                      Icon(CupertinoIcons.money_dollar,
                                        color: Colors.greenAccent,)
                                    ],),
                                  Row(
                                    children: [
                                      TextButton(
                                          child: Text('1' ),
                                          onPressed: () {}),
                                      Icon(CupertinoIcons.money_dollar,
                                        color: Colors.greenAccent,)
                                    ],),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Center(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/ConfirmTopUp');
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Color(0xFF007AFF),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text( 'Custom Your Amount',
                                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Spacer(),
                      Spacer(),
                      Spacer(),
                    ]
                ),
              )

          ),
        ),
      ),
    );
  }

  void fetchUserDetails() async {

    var queryParameters = {
      'mobileNumber': NUMBER
    };

    var uri = Uri.http(backendURL, '/api/users/fetch.php', queryParameters);

    var response = await http.get(uri);
    String serverResponse = response.body;

    Map<String, dynamic> map = jsonDecode(serverResponse);
    if(map['status'] == 'success') {
      NAME = map['name'];
      IMAGE = map['image'];
      DOB = map['dob'];
      GENDER = map['gender'];
      SYMBOL = map['symbol'];
      BALANCE = map['balance'];
      PIN = map['pin'];

      setState(() {
        CURRENCY_CODE = map['currency'];
      });
    }
  }
}