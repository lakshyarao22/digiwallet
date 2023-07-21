import 'package:digital_wallet/Widgets/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_wallet/Dashboard/Home/transactions.dart';
import 'package:digital_wallet/Dashboard/Home/conversions.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {

  TabController _tabController;
  Widget _transactionTab = Transactions();
  Widget _conversionsTab = Conversions();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 2);
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
              padding: EdgeInsets.only(top: 16, bottom: 0, left: 16, right: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Container(margin: EdgeInsets.only(bottom: 8), child: Text('History', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: primaryColor,
                    labelColor: primaryColor,
                    tabs: <Widget>[
                      new Tab(text: 'Transactions',),
                      new Tab(text: 'Conversions',),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  _transactionTab,
                  _conversionsTab,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
