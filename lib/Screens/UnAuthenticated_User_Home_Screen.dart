import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:customer_app/Components/Constants.dart';
import 'package:customer_app/Components/Size_Configurations.dart';
import 'package:customer_app/Components/Navigator.dart';
import 'package:customer_app/Components/Carousel.dart';
import 'package:customer_app/Models/Movies_Model.dart';
import 'package:customer_app/Screens/Sign_Up_Screen.dart';
import 'package:customer_app/Screens/Sign_In_Screen.dart';

class UnAuthenticatedHomeScreen extends StatefulWidget {
  @override
  _UnAuthenticatedHomeScreenState createState() =>
      _UnAuthenticatedHomeScreenState();
}

class _UnAuthenticatedHomeScreenState extends State<UnAuthenticatedHomeScreen> {
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
                Icons.group_add,
                color: SubMainColor,
              ),
              onPressed: buttonsAction,
              iconSize: 35,
            ),
          ],
          leading: Container(),
        ),
        body: ListView(
          children: [
            imagecarousel,
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.defaultSize * 2,
                left: SizeConfig.defaultSize - 2,
              ),
              child: Text(
                'Browse Movies:',
                style: HomeLabelFontStyle,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.defaultSize),
              height: SizeConfig.defaultSize * 45.0,
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

  void buttonsAction() {
    showDialog(
        context: context,
        child: AlertDialog(
          backgroundColor: Colors.blueGrey[900],
          elevation: 1.0,
          content: Text(
            'Welcome to Your Cinema App',
            style: TextStyle(
              color: MainFontsColor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          actions: [
            ButtonTheme(
              child: RaisedButton(
                color: SubMainColor,
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  CustomRouter().navigator(context, SignUp());
                },
              ),
            ),
            ButtonTheme(
              child: RaisedButton(
                color: SubMainColor,
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  CustomRouter().navigator(context, SignIn());
                },
              ),
            ),
          ],
        ));
  }
}
