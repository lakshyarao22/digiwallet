import 'dart:async';
import 'dart:ui';

import 'package:digital_wallet/Dashboard/dashboard.dart';
import 'package:digital_wallet/Widgets/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../global-variables.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:digital_wallet/Login/getUserDetails.dart';

class VerifyOTP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Kodchasan'),
      home: BuildUI(),
    );
  }
}

class BuildUI extends StatefulWidget {
  @override
  _BuildUIState createState() => _BuildUIState();
}

class _BuildUIState extends State<BuildUI> {
  Timer _timer;
  var resendVal = 60;
  bool roVisibility = false;
  bool timerVisibility = true;

  @override
  void initState() {
    _timer = Timer.periodic(new Duration(seconds: 60), (timer) {
      setState(() {
        resendVal--;
        if (resendVal <= 0) {
          _timer.cancel();
          _timer = null;
          roVisibility = true;
          timerVisibility = false;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Container(
                padding:
                    EdgeInsets.only(top: 56, bottom: 16, left: 16, right: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Align(
                  alignment: FractionalOffset.bottomLeft,
                  child: Text(
                    'OTP Verification Code',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              margin: EdgeInsets.only(top: 10),
              child: RichText(
                text: TextSpan(
                  text:
                      'Please enter the OTP code just sent to the phone number: ',
                  style: TextStyle(
                      color: greyTextColor,
                      fontFamily: 'Kodchasan',
                      fontSize: 15),
                  children: <TextSpan>[
                    TextSpan(
                      text: enteredNumber,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Kodchasan',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Center(
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  enableActiveFill: true,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.white,
                      activeColor: Colors.white,
                      selectedFillColor: Colors.white,
                      selectedColor: primaryColor),
                  keyboardType: TextInputType.number,
                  animationDuration: Duration(milliseconds: 300),
                  onCompleted: (pin) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserDetails()));
                  },
                  onChanged: (String value) {},
                ),
              ),
            ),
            Spacer(),
            Visibility(
              visible: timerVisibility,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                  width: 80,
                  height: 30,
                  child: Center(
                    child: Text(
                      '00:' + '$resendVal',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          fontFamily: 'Kodchasan'),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: roVisibility,
              child: RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => {
                            Navigator.of(context, rootNavigator: true)
                                .pop(context)
                          },
                    text: 'Didn\'t receive the OTP?',
                    style: TextStyle(
                        color: greyTextColor, fontFamily: 'Kodchasan'),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {print("sd")},
                          text: ' Resend OTP',
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kodchasan'))
                    ]),
              ),
            ),
            Spacer(),
            Container(
              child: RichText(
                  text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () =>
                      {Navigator.of(context, rootNavigator: true).pop(context)},
                text: 'Change Phone Number',
                style: TextStyle(
                    fontSize: 16, color: primaryColor, fontFamily: 'Kodchasan'),
              )),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: primaryColor))),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardProcess()));
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
