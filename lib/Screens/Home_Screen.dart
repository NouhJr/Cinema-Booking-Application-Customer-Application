import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:customer_app/Components/Constants.dart';
import 'package:customer_app/Components/Size_Configurations.dart';
import 'package:customer_app/Components/Navigator.dart';
import 'package:customer_app/Components/FlushBar.dart';
import 'package:customer_app/Models/Movies_Model.dart';
import 'package:customer_app/Screens/UnAuthenticated_User_Home_Screen.dart';
import 'package:customer_app/Screens/Notifications_Screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //Size Configurations to resize widgets according to screen size.
    SizeConfig().init(context);
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          title: Text(
            'Your Cinema',
            style: AppBarFontStyle,
          ),
          centerTitle: true,
          backgroundColor: MainColor,
          elevation: 1.0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: SubMainColor,
              ),
              onPressed: () {
                CustomRouter().navigator(context, NotificationsScreen());
              },
              iconSize: 35,
            ),
            IconButton(
              icon: Icon(
                Icons.logout,
                color: SubMainColor,
              ),
              onPressed: logOut,
              iconSize: 35,
            ),
          ],
          leading: Container(),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: SizeConfig.defaultSize),
              height: SizeConfig.defaultSize * 70,
              child: MoviesStream(),
            ),
          ],
        ),
      ),
      onWillPop: _onWillPop,
    );
  }

  // ignore: missing_return
  Future<bool> _onWillPop() {
    SystemNavigator.pop();
  }

  final _auth = FirebaseAuth.instance;

  void logOut() async {
    //Check if there is internet connection or not and display message error if not.
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(context,
          title: "No internet connection !",
          message: "Pleas turn on wifi or mobile data",
          icons: Icons.signal_wifi_off);
    } else {
      _auth.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('EMAIL');
      CustomRouter().navigator(context, UnAuthenticatedHomeScreen());
    }
  }
}
