import 'package:digital_wallet/Widgets/Color.dart';
import 'package:digital_wallet/global-variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sizer/sizer.dart';

class Recharges extends StatefulWidget {
  @override
  _RechargesState createState() => _RechargesState();
}

final controller = TextEditingController();

@override
class _RechargesState extends State<Recharges> {
  var Data = 0.0;

  Future<Recharges> fetchRecharge() async {
    var headers = {'Authorization': '$tokenType $authToken'};
    var request = http.Request(
        'GET', Uri.parse("ReloadlyUrl + operators/commissions?page=1&size=3"));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String jsonVal = await response.stream.bytesToString();
    Map newJson = jsonDecode(jsonVal);

    if (response.statusCode == 200) {
      print(newJson);
      setState(() {
        Data = newJson['content'][0]['percentage'];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return Scaffold(
          backgroundColor: bgColor,
          body: Stack(children: [
            Container(
                padding: EdgeInsets.all(20.sp),
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/Images/img3.png',
                  width: 80.w,
                )),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 10.sp),
                  alignment: Alignment.bottomCenter,
                  height: 15.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.sp),
                          bottomRight: Radius.circular(20.sp))),
                  child: Text(
                    "Mobile Recharge",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 3.sp),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.sp)),
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: InputBorder.none, labelText: 'Phone Number'),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 3.sp),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.sp)),
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 0.sp),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: InputBorder.none, labelText: 'Operator'),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 3.sp),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.sp)),
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none, labelText: 'Amount'),
                  ),
                )
              ],
            ),
          ]));
    });
  }
}

class Prepaid extends StatefulWidget {
  const Prepaid({Key key}) : super(key: key);

  @override
  _PrepaidState createState() => _PrepaidState();
}

class _PrepaidState extends State<Prepaid> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Postpaid extends StatefulWidget {
  const Postpaid({Key key}) : super(key: key);

  @override
  _PostpaidState createState() => _PostpaidState();
}

class _PostpaidState extends State<Postpaid> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
