import 'dart:convert';
import 'dart:io';

import 'package:digital_wallet/Dashboard/chooseBank.dart';
import 'package:digital_wallet/Widgets/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';
import 'package:http/http.dart' as http;



class ConfirmTopup extends StatefulWidget {
  @override
  _ConfirmTopupState createState() => _ConfirmTopupState();
}

class _ConfirmTopupState extends State<ConfirmTopup> {
  var selectedBank = "Arco Bank";
  var topUpAmount = "1000";
  var feesAmount = "0";
  var totalAmount = "1000";

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType){
      return Scaffold(
        // resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFF56585A),
        body: SafeArea(
          child: Stack(children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w,),
              decoration: BoxDecoration(
                  color: Color(0xFFCBD5E0),
                  borderRadius: BorderRadius.circular(20)),
            ),
            Container(
              margin: EdgeInsets.only(top: 3.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20), topRight: Radius.circular(20))),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 170.0),
                    padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Stack(children: [
                    Center(
                      heightFactor: 1.6,
                      child: Text(
                        'Confirm Top Up',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          alignment: FractionalOffset.topLeft,
                          child: Image.asset(
                            'assets/Icons/left.png',
                            fit: BoxFit.cover,
                            width: 55,
                            height: 55,
                          ),
                        )),
                  ]),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Source of Fund',
                        style: TextStyle(fontSize: 20),
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => chooseBank()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/Icons/LogoAC.png',
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                selectedBank,
                                style: TextStyle(fontSize: 25),
                              )),
                          Spacer(),
                          Image.asset(
                            'assets/Icons/Iconright.png',
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Amount',
                                style: TextStyle(fontSize: 20),
                              )),
                          Spacer(),
                          Icon(
                            CupertinoIcons.money_dollar,
                            color: Colors.greenAccent,
                          ),
                          Text(
                            topUpAmount,
                            style: TextStyle(fontSize: 25, color: greyTextColor),
                          ),
                          Icon(
                            CupertinoIcons.arrow_right,
                            color: greyTextColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Fees',
                                style: TextStyle(fontSize: 20),
                              )),
                          Spacer(),
                          Text(
                            feesAmount,
                            style: TextStyle(fontSize: 25, color: greyTextColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(fontSize: 20, color: greyTextColor),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  CupertinoIcons.money_dollar,
                                  color: Colors.greenAccent,
                                  size: 30,
                                ),
                                Text(
                                  totalAmount,
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          // fetchbalance();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/Icons/Imageshield.png",
                                fit: BoxFit.cover,
                                height: 30,
                                width: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2),
                                child: Text(
                                  "Top-Up",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/Icons/LogoPCI-DSS.png",
                          fit: BoxFit.cover,
                          height: 30,
                          width: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("PCI-DSS Security Standards certificate"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      );
      }
    );
  }
}
