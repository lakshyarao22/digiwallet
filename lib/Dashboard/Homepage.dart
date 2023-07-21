import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PanelController _pc = PanelController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SafeArea(
      child: Column(children: [
        Container(
          margin: EdgeInsets.fromLTRB(20.0, 30.0, 10.0, 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Search for everything...',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              GestureDetector(
                onTap: () {}, // handle your image tap here
                child: Image.asset(
                  'assets/Icons/iconBell.png',
                  fit: BoxFit.cover,
                  // this is the solution for border
                  width: 40.0,
                  height: 40.0,
                ),
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Balance',
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('USD 100.00  ',
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF63C47B))),
                      Image.asset(
                        'assets/Icons/iconeyes.png',
                        height: 30,
                        width: 30,
                      )
                    ])
              ],
            )),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => _pc.open(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/Icons/icontopup.png',
                          height: 50,
                          width: 50,
                        ),
                        Text('Top Up'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/Icons/Imagewithdraw.png',
                          height: 50,
                          width: 50,
                        ),
                        Text('Withdraw'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/Icons/iconTransfer.png',
                          height: 50,
                          width: 50,
                        ),
                        Text('Transfer'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/Icons/Imagehistory.png',
                          height: 50,
                          width: 50,
                        ),
                        Text('History'),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/Icons/iconGrocery.png',
                              height: 50,
                              width: 50,
                            ),
                            Text('Grocery'),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/Icons/iconShopping.png',
                              height: 50,
                              width: 50,
                            ),
                            Text('Shopping'),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/Icons/iconFood.png',
                              height: 50,
                              width: 50,
                            ),
                            Text('Food'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/Icons/iconBarcode.png',
                              height: 50,
                              width: 50,
                            ),
                            Text('Barcode'),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/Icons/iconVoucher.png',
                              height: 50,
                              width: 50,
                            ),
                            Text('Voucher'),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/Icons/iconTicket.png',
                              height: 50,
                              width: 50,
                            ),
                            Text('Ticket'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/Icons/iconUtilities.png',
                              height: 50,
                              width: 50,
                            ),
                            Text('Utilities'),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/Icons/iconMobile.png',
                              height: 50,
                              width: 50,
                            ),
                            Text('Mobile'),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/Icons/iconFeatures.png',
                              height: 50,
                              width: 50,
                            ),
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
      ]),
    ));
  }
}
