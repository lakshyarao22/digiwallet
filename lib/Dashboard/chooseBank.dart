import 'package:digital_wallet/Widgets/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

// ignore: camel_case_types
class chooseBank extends StatefulWidget {
  @override
  _chooseBankState createState() => _chooseBankState();
}

// ignore: camel_case_types
class _chooseBankState extends State<chooseBank> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, screenType){
      return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xFF56585A),
          body: Stack(children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 7.h),
              decoration: BoxDecoration(
                  color: Color(0xFFCBD5E0),
                  borderRadius: BorderRadius.circular(20)),
            ),
            Container(
                margin: EdgeInsets.only(top: 10.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 170.0),
                        padding:
                            EdgeInsets.symmetric(vertical: 3.0, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Stack(children: [
                        Center(
                          heightFactor: 1.6,
                          child: Text(
                            'Source Of Funds',
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
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(8),
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    "assets/Icons/LogoAC.png",
                                    fit: BoxFit.cover,
                                    width: 70,
                                    height: 70,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Arco Bank",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  Spacer()
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    "assets/Icons/LogoAG.png",
                                    width: 50,
                                    height: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "AG Bank",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  Spacer()
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    "assets/Icons/LogoCity.png",
                                    width: 50,
                                    height: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "City Bank",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  Spacer()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          margin: const EdgeInsets.all(50.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(20),
                            // color: bgColor
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/Icons/ImagePlus.png",
                                height: 45,
                                width: 45,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Add Fund Source",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]))
          ])
      );}
    );
  }
}
