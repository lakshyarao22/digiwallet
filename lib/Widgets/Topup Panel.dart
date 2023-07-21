import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class topUpPanel extends StatefulWidget {
  @override
  _topUpPanelState createState() => _topUpPanelState();
}

// ignore: camel_case_types
class _topUpPanelState extends State<topUpPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SlidingUpPanel(
        panel: Center(
          child: Text("This is the sliding Widget"),
        ),
        body: Center(
          child: Text("This is the Widget behind the sliding panel"),
        ),
      ),
    );
  }
}
