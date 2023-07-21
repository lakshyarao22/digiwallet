import 'package:digital_wallet/global-variables.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dashboard/dashboard.dart';
import 'Login/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkLogin();
  if (NUMBER == '') {
    runApp(LoginProcess());
  } else {
    NUMBER = NUMBER.split("-")[1];
    runApp(DashboardProcess());
  }
}

Future<void> checkLogin() async {
  final prefs = await SharedPreferences.getInstance();
  NUMBER = prefs.getString('MOBILE_NUMBER') ?? '';
}
