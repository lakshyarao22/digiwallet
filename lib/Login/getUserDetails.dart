import 'dart:convert';
import 'dart:io';

import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:digital_wallet/Dashboard/dashboard.dart';
import 'package:digital_wallet/Widgets/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:digital_wallet/global-variables.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserDetails extends StatelessWidget {
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

final controller = TextEditingController();

@override
void dispose() {
  controller.dispose();
}

class _BuildUIState extends State<BuildUI> {

  File _image;
  final picker = ImagePicker();

  String genderValue = 'Male';
  String selectedDate = 'September 25, 1996';

  List months = ['January', 'February', 'March', 'April', 'May','June','July','August','September','October', 'November', 'December'];

  String userPin = '';
  String filePath = '';

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height-25;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  child: Container(
                    padding: EdgeInsets.only(top: 56, bottom: 16, left: 16, right: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Align(
                      alignment: FractionalOffset.bottomLeft,
                      child: Text('Fill up details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final pickedFile = await picker.getImage(source: ImageSource.gallery);
                    setState(() {
                      if(pickedFile != null) {
                        _image = File(pickedFile.path);
                        filePath = pickedFile.path;
                      } else {
                        print('No image selected.');
                      }
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        alignment: FractionalOffset.center,
                        margin: EdgeInsets.only(top: 16),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: (_image != null) ? FileImage(_image) : ExactAssetImage('assets/Images/profile_image.png'),
                        ),
                      ),
                      Container(
                        alignment: FractionalOffset.center,
                        margin: EdgeInsets.only(top: 96, left: 60),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: primaryColor,
                          child: Icon(CupertinoIcons.camera_fill, color: Colors.white, size: 18,),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    controller: controller,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Full Name',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              final DateTime picked = await showDatePicker(
                                  context: context,
                                  helpText: 'Date Of Birth',
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                              );
                              if(picked != null) {
                                setState(() {
                                  selectedDate = months[picked.month-1]+" "+picked.day.toString()+", "+picked.year.toString();
                                });
                              }
                            },
                              child: Text('$selectedDate', style: TextStyle(fontSize: 15, color: Colors.black),)),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Align(
                            alignment: FractionalOffset.center,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: '$genderValue',
                                items: <String>['Male', 'Female', 'Other'].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (String newValue) {
                                  setState(() {
                                    genderValue = newValue;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 26, left: 20),
                  alignment: FractionalOffset.centerLeft,
                  child: Text('Setup your PIN', style: TextStyle(color: greyTextColor),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 26),
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 4,
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
                        selectedColor: primaryColor
                    ),
                    keyboardType: TextInputType.number,
                    animationDuration: Duration(milliseconds: 300),
                    onChanged: (String value) { userPin = value; },
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: double.infinity),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: primaryColor)
                                  )
                              ),
                            ),
                            onPressed: () { registerUser(context, enteredNumber, controller.text, filePath, selectedDate, genderValue, userPin); },
                            child: Container(margin: EdgeInsets.symmetric(vertical: 15,),child: Text('Sign Up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void registerUser(BuildContext context, String mobileNumber, String userName, String filePath, String dob, String gender, String pinCode) async {

  ProgressDialog _progressDialog = ProgressDialog();
  bool success = false;

  if(userName.trim().isEmpty) {
    Fluttertoast.showToast(
        msg: 'Please enter a valid name',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }
  if(pinCode.length < 4) {
    Fluttertoast.showToast(
        msg: 'Please enter a valid PIN',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }
  else {

    _progressDialog.showProgressDialog(context);

    var request = http.MultipartRequest("POST", Uri.http(backendURL, '/api/users/create.php'));
    request.fields['mobileNumber'] = mobileNumber;
    request.fields['userName'] = userName;
    request.fields['dob'] = dob;
    request.fields['gender'] = gender;
    request.fields['pinCode'] = pinCode;

    if(filePath.isNotEmpty) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath('userImage', filePath);
      request.files.add(multipartFile);
    }

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        String serverResponse = response.body;

        Map<String, dynamic> map = jsonDecode(serverResponse);
        var status = map['status'];
        var responseText = map['responseText'];

        Color color;

        if(status == 'success') {
          color = Colors.green;
          success = true;
        }
        else {
          color = Colors.red;
          responseText = 'Number is already registered with us';
        }

        _progressDialog.dismissProgressDialog(context);

        Fluttertoast.showToast(
            msg: responseText,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: color,
            textColor: Colors.white,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);

        if(success) {
          savePreferences();
          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardProcess()));
        }
      });
    });
  }
}

savePreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('MOBILE_NUMBER', enteredNumber);
}

