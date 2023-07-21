import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:digital_wallet/Widgets/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../global-variables.dart';
import 'package:digital_wallet/Dashboard/Home/confirm-transfer.dart';

class Transfer extends StatefulWidget {
  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {

  List<String> localNumbers = <String>[];

  List<RecipientItem> _recipientList = [];
  List<RecipientItem> _searchResult = [];
  final controller = TextEditingController();

  Future _future;

  Future<List<RecipientItem>> _getRecipients() async {

    Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);

    contacts.forEach((contact) {
      contact.phones.toSet().forEach((phone) {
        var val = phone.value.replaceAll(" ", '');
        if(val.length >= 10 && isNumeric(val)) {
          localNumbers.add(val.substring(val.length - 10));
        }
      });
    });

    var url = Uri.http(backendURL, '/api/users/recipients.php');

    var data = new Map<String, String>();

    data['mobileNumber'] = NUMBER;
    data['localNumbers'] = "("+localNumbers.join(", ")+")";

    http.Response response = await http.post(url, body: data);

    var jsonData = jsonDecode(response.body);

    for(var json in jsonData) {
      _recipientList.add(new RecipientItem(json['image'], json['name'], json['number']));
    }

    return _recipientList;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  void initState() {
    super.initState();
    _future = _getRecipients();
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    _getRecipients();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: bgColor,
      body: SafeArea(
        child: SmartRefresher(
          enablePullUp: false,
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 16),
                alignment: FractionalOffset.topCenter,
                child: Text('Select Recipient', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Stack(
                  children: [
                    Container(child: Image.asset('assets/Images/search.png'), margin: EdgeInsets.only(top: 12),),
                    Container(
                      margin: EdgeInsets.only(left: 36),
                      child: TextField(
                        onChanged: onSearchTextChanged,
                        controller: controller,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type name or phone number',
                          hintStyle: TextStyle(
                            color: Color(0xFFCBD5E0)
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: FractionalOffset.centerLeft,
                  margin: EdgeInsets.only(left: 16),
                  child: Text('Friends Use Afriiqpay', style: TextStyle(color: CupertinoColors.black, fontWeight: FontWeight.bold, fontSize: 15),),
              ),
              Container(
                height: 416,
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: FutureBuilder(
                  future: _future,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.data == null) {
                      return Center(
                        child: Text('Loading...'),
                      );
                    }
                    else {
                      return _searchResult.length != 0 || controller.text.isNotEmpty
                          ? new ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _searchResult.length,
                        itemBuilder: (context, i) {
                          return new ListTile(
                            leading: new CircleAvatar(
                              backgroundImage: new NetworkImage(
                                _searchResult[i].image
                                ,),
                            ),
                            title: new Text(_searchResult[i].name, style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(_searchResult[i].number),
                            onTap: () {
                              Navigator.push(context, new MaterialPageRoute(builder: (context) => ConfirmTransfer(recipientItem: _searchResult[i])));
                            },
                          );
                        },
                      )
                       : ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                snapshot.data[index].image,
                              ),
                            ),
                            title: Text(snapshot.data[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(snapshot.data[index].number),
                            onTap: () {
                              Navigator.push(context, new MaterialPageRoute(builder: (context) => ConfirmTransfer(recipientItem: snapshot.data[index])));
                              },
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _recipientList.forEach((recipient) {
      if (recipient.name.toLowerCase().contains(text.toLowerCase()) || recipient.number.contains(text))
        _searchResult.add(recipient);
    });

    setState(() {});
  }

}

class RecipientItem {
  String image;
  String name;
  String number;

  RecipientItem(this.image, this.name, this.number);
}

