import 'package:digital_wallet/Dashboard/Home/Wallet.dart';
import 'package:digital_wallet/Widgets/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:digital_wallet/Dashboard/Home/main-home.dart';

class DashboardProcess extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return true;
      },
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Kodchasan'),
        home: BuildUI(),
      ),
    );
  }
}

// ignore: must_be_immutable
class BuildUI extends StatefulWidget {
  @override
  _BuildUIState createState() => _BuildUIState();

}

class _BuildUIState extends State<BuildUI> {

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[MainHome(), Wallet(), Text('QR Code',), Text('Profile',),];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: GNav(
            rippleColor: Colors.grey[800], // tab button ripple color when pressed
            hoverColor: Colors.grey[700], // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 15,
            curve: Curves.easeOutExpo, // tab animation curves
            duration: Duration(milliseconds: 900), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            iconSize: 24, // tab button icon size
            tabBackgroundColor: Colors.grey.withOpacity(0.1), // selected tab background color
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // navigation bar padding
            tabs: [
              GButton( // ignore: missing_required_param
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/Icons/Home.png"),
                ),
                text: 'Home',
              ),
              GButton( // ignore: missing_required_param
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/Icons/Wallet.png"),
                ),
                text: 'Wallet',
              ),
              GButton( // ignore: missing_required_param
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/Icons/QrCode.png"),
                ),
                text: 'QR Code',
              ),
              GButton( // ignore: missing_required_param
                leading: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/Icons/profile.png"),
                ),
                text: 'Profile',
              )
            ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}