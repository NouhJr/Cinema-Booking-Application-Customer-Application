import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/Screens/UnAuthenticated_User_Home_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    //Start point (Home Screen)
    home: UnAuthenticatedHomeScreen(),
  ));
}
