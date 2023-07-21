import 'package:digital_wallet/Widgets/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:digital_wallet/global-variables.dart';
import 'package:url_launcher/url_launcher.dart';
import 'verifyOTP.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterProcessOne extends StatelessWidget {
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
  changeCode() {
    setState(() {
      selectedCountryCode = selectedCountryCode;
    });
  }

  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 120),
              child: Align(
                alignment: FractionalOffset.topRight,
                child: Image.asset('assets/Images/phn_bg.png'),
              ),
            ),
            Column(
              children: [
                Container(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 56, bottom: 16, left: 16, right: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Align(
                      alignment: FractionalOffset.bottomLeft,
                      child: Text(
                        'Enter your phone number',
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
                  child: Align(
                    alignment: FractionalOffset.centerLeft,
                    child: SizedBox(
                      width: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 14, left: 70),
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: primaryColor,
                              ),
                            ),
                            CountryCodePicker(
                              initialSelection: 'US',
                              showCountryOnly: true,
                              onChanged: (CountryCode countryCode) {
                                selectedCountryCode = countryCode.toString();
                                changeCode();
                              },
                              showOnlyCountryWhenClosed: false,
                              alignLeft: true,
                              textStyle: TextStyle(
                                color: Colors.black.withOpacity(0.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  margin: EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: FractionalOffset.centerLeft,
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '$selectedCountryCode',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 150,
                            child: TextField(
                              controller: controller,
                              focusNode: focusNode,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Mobile Number',
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.clear();
                            },
                            child: Icon(
                              CupertinoIcons.multiply,
                              color: primaryColor,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      margin: EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: FractionalOffset.bottomLeft,
                        child: RichText(
                          text: TextSpan(
                            text: 'By signing in you accept our',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontFamily: 'Kodchasan'),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '\nTerms of use',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        {launch('https://www.google.com')}),
                              TextSpan(text: ' and '),
                              TextSpan(
                                  text: 'Privacy policy',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        {launch('https://www.google.com')}),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      margin: EdgeInsets.only(top: 10),
                      child: Container(
                        child: Column(
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minWidth: double.infinity),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                  color: primaryColor)))),
                                  onPressed: () {
                                    if (controller.text.length > 0) {
                                      return showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Verify Phone Number'),
                                            content: RichText(
                                              text: TextSpan(
                                                text:
                                                    'We will be verifying the phone number: ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontFamily: 'Kodchasan'),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          selectedCountryCode +
                                                              '-' +
                                                              controller.text,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text:
                                                          '. Is this OK, or would you like to edit the number?'),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    focusNode.requestFocus();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Edit')),
                                              TextButton(
                                                  onPressed: () {
                                                    enteredNumber =
                                                        selectedCountryCode +
                                                            "-" +
                                                            controller.text;
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                VerifyOTP()));
                                                  },
                                                  child: Text('Verify')),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Mobile Number is required!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                    }
                                  },
                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      child: Text(
                                        'Next',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
