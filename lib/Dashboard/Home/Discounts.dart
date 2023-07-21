import 'package:digital_wallet/global-variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class Discounts extends StatefulWidget {
  @override
  _DiscountsState createState() => _DiscountsState();
}

class _DiscountsState extends State<Discounts> {
  var Data = 0.0;

  Future<Discounts> fetchDiscount() async {
    var headers = {
      'Authorization': '$tokenType $authToken'
    };
    var request = http.Request('GET', Uri.parse("'$ReloadlyUrl operators/commissions?page=1&size=3'"));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String jsonVal = await response.stream.bytesToString();
    Map newJson = jsonDecode(jsonVal);

    if (response.statusCode == 200) {
      setState(() {
        Data = newJson['content'][0]['percentage'];
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floating Action Button'),
      ),
      body: Center(child: Text("$Data")
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchDiscount();
        },
        child: const Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }
}
