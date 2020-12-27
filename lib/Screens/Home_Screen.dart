import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:customer_app/Components/Constants.dart';
import 'package:customer_app/Components/Size_Configurations.dart';
import 'package:customer_app/Models/Movies_Model.dart';

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
              onPressed: () {},
              iconSize: 35,
            ),
          ],
        ),
        drawer: Drawer(),
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
}
