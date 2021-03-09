import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:customer_app/Screens/UnAuthenticated_User_Home_Screen.dart';
import 'package:customer_app/Screens/Home_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('EMAIL');
  await Firebase.initializeApp();
  runApp(MaterialApp(
    //Start point (Home Screen)
    debugShowCheckedModeBanner: false,
    title: "Your Cinema - Customer",
    home: email == null ? UnAuthenticatedHomeScreen() : Home(),
  ));
}
