import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:customer_app/Components/Constants.dart';
import 'package:customer_app/Components/Custom_Text_Field.dart';
import 'package:customer_app/Components/Size_Configurations.dart';
import 'package:customer_app/Components/Navigator.dart';
import 'package:customer_app/Components/FlushBar.dart';
import 'package:customer_app/Screens/Home_Screen.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    //Size Configurations to resize widgets according to screen size.
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(
        margin: EdgeInsets.only(
          top: SizeConfig.defaultSize * 20.0,
          left: SizeConfig.defaultSize,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: SizeConfig.defaultSize * 2.0,
              ),
              child: Text(
                "Sign In",
                style: AppBarFontStyle,
              ),
            ),
            Textfield(
              controller: emailController,
              label: 'Email',
              hint: 'Enter your email...',
              isSecure: false,
            ),
            Textfield(
              controller: passwordController,
              label: 'Password',
              hint: 'Enter your password...',
              isSecure: true,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: signIn,
        label: Text(
          "Sign In",
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey[900],
          ),
        ),
        backgroundColor: SubMainColor,
        icon: Icon(
          Icons.login,
          color: Colors.blueGrey[900],
          size: 30.0,
        ),
      ),
    );
  }

  ///*****************************BACK END****************************************/
  //Text Editing Controllers to get data from Text Fields.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  void titleDispose() {
    emailController.dispose();
    super.dispose();
  }

  void timeDispose() {
    passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    //Check if there is internet connection or not and display message error if not.
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(
        context,
        title: "No internet connection !",
        message: "Pleas turn on wifi or mobile data",
        icons: Icons.signal_wifi_off,
      );

      //Ensure that 'Movie Title' field isn't empty.
    } else if (emailController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Email field can't be empty !",
        message: 'Please enter your email.',
        icons: Icons.warning,
      );

      //Validate 'email' text field to make sure it contains '@'.
    } else if (!emailController.text.contains('@')) {
      Warning().errorMessage(
        context,
        title: 'Invalid email !',
        message: "Email must contain '@' ",
        icons: Icons.warning,
      );
      emailController.clear();
      passwordController.clear();

      //Validate 'email' text field to make sure it contains '.com'.
    } else if (!emailController.text.contains('.com')) {
      Warning().errorMessage(
        context,
        title: 'Invalid email !',
        message: "Email must contain '.com' ",
        icons: Icons.warning,
      );
      emailController.clear();
      passwordController.clear();

      //Validate 'password' text field to make sure it's not empty.
    } else if (passwordController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Password field can't be empty !",
        message: "Please enter your password",
        icons: Icons.warning,
      );
      emailController.clear();

      //Validate 'password' text field to make sure it's more than 6 characters in length.
    } else if (passwordController.text.length < 6) {
      Warning().errorMessage(
        context,
        title: "Invalid password length !",
        message: "Password length must be 6 characters or more",
        icons: Icons.warning,
      );
      emailController.clear();
      passwordController.clear();

      //Routing the user to 'Home Screen' and display loading spinner while routing.
    } else {
      try {
        final newUser = await auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('EMAIL', emailController.text);
        if (newUser != null) {
          CustomRouter().navigator(context, Home());
        }
      } catch (e) {
        //Showing error message if sign in process failed.
        Warning().errorMessage(
          context,
          title: "SignIn failed !",
          message: "Email or password is wrong.",
          icons: Icons.warning,
        );
        emailController.clear();
        passwordController.clear();
      }
    }
  }
}
