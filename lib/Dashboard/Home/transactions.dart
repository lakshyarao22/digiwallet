import 'dart:convert';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:digital_wallet/Widgets/Color.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../global-variables.dart';
import 'package:digital_wallet/Dashboard/Home/transaction-details.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  List<TransactionItem> _transactionList = [];

  String startDate = DateFormat('yyyy-MM-dd').format(new DateTime.now().add(const Duration(days: -10)));
  String endDate = DateFormat('yyyy-MM-dd').format(new DateTime.now());

  String dateFormatText;

  Future _future;

  ProgressDialog _progressDialog = ProgressDialog();

  @override
  initState() {
    dateFormatText = DateFormat('MMM dd, yyyy').format(new DateTime.now().add(const Duration(days: -10)))+" - "+DateFormat('MMM dd, yyyy').format(new DateTime.now());
    _future = _getTransactions();
    super.initState();
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _future = _getTransactions();
    });
    _refreshController.refreshCompleted();
  }

  Future<List<TransactionItem>> _getTransactions() async {

    _progressDialog.showProgressDialog(context);

    _transactionList.clear();

    var queryParameters = {
      'mobileNumber': NUMBER,
      'startDate': '$startDate',
      'endDate': '$endDate',
    };

    var uri = Uri.http(backendURL, '/api/users/transactions.php', queryParameters);

    var response = await http.get(uri);
    String serverResponse = response.body;

    var jsonData = jsonDecode(serverResponse);

    for(var json in jsonData) {
      _transactionList.add(new TransactionItem(json['id'], json['image'], json['name'], json['timestamp'], json['amount'], json['status']));
    }

    _progressDialog.dismissProgressDialog(context);

    return _transactionList;
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return SafeArea(
      child: SmartRefresher(
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                return showDialog(context: context, builder: (context){
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 350,
                          child: Container(
                            width: 250,
                            child: SfDateRangePicker(
                              selectionMode: DateRangePickerSelectionMode.range,
                              initialSelectedRange: PickerDateRange(DateTime.now().subtract(const Duration(days: 10)), DateTime.now()),
                              onSelectionChanged: _onSelectionChanged,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                    return primaryColor;
                                  },),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: primaryColor)))),
                            onPressed: () {
                                setState(() {
                                  _future = _getTransactions();
                                });
                                Navigator.pop(context);
                            },
                            child: Text('Set', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  );
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 26),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$dateFormatText', style: TextStyle(fontWeight: FontWeight.bold),),
                    Icon(Icons.arrow_drop_down, color: primaryColor,)
                  ],
                ),
              ),
            ),
            Container(
              height: 400,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: FutureBuilder(
                future: _future,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.data == null) {
                    return Center(
                      child: Text("Loading..."),
                    );
                  }
                  else {
                    if(_transactionList.isEmpty) {
                      return Center(
                        child: Text("No transactions in this period"),
                      );
                    }
                    else {
                      return new ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data[index].image),
                            ),
                            title: Text(snapshot.data[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(snapshot.data[index].timestamp, style: TextStyle(fontSize: 12, color: greyTextColor),),
                            trailing: Column(
                              children: [
                                Container(margin: EdgeInsets.symmetric(vertical: 6), child: Text(snapshot.data[index].amount, style: TextStyle(fontWeight: FontWeight.bold),)),
                                Text(snapshot.data[index].status, style: TextStyle(fontSize: 12, color: Colors.green),),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(context, new MaterialPageRoute(builder: (context) => TransactionDetails(transactionID: snapshot.data[index].id)));
                            },
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        startDate = DateFormat('yyyy-MM-dd').format(args.value.startDate);
        if(args.value.endDate != null) {
          endDate = DateFormat('yyyy-MM-dd').format(args.value.endDate);

          dateFormatText = DateFormat('MMM dd, yyyy').format(args.value.startDate)+" - "+DateFormat('MMM dd, yyyy').format(args.value.endDate);
        }
      }
    });
  }
}

class TransactionItem {
  String id;
  String image;
  String name;
  String timestamp;
  String amount;
  String status;

  TransactionItem(this.id, this.image, this.name, this.timestamp, this.amount, this.status);
}
