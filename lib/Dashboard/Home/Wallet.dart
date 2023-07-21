import 'dart:ui';

import 'package:digital_wallet/Widgets/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();


}

class _WalletState extends State<Wallet> {
  List<String> widgetList = ['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, screenType) {
          return
            Scaffold(
              backgroundColor: bgColor,
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                      color: Colors.white
                    ),
                    height: 15.h,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text('My Wallet', style: TextStyle(fontSize: 3.h, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                          margin: EdgeInsets.symmetric( horizontal: 2.h, vertical: 2.w),
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: Text('Balance',
                                  style: TextStyle(fontSize: 15.sp),),
                              ),

                            ],
                          )
                      ),
                    ),
                  ),
                ],
              ),
            );
        }
        );
  }
}
