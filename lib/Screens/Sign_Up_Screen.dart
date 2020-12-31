import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:customer_app/Components/Constants.dart';
import 'package:customer_app/Components/Custom_Text_Field.dart';
import 'package:customer_app/Components/Size_Configurations.dart';
import 'package:customer_app/Components/Navigator.dart';
import 'package:customer_app/Components/FlushBar.dart';
import 'package:customer_app/Screens/Image_Selection.dart';
import 'package:customer_app/Screens/Home_Screen.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //variable '_image' to hold selected image.
  File _image;
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    //Size Configurations to resize widgets according to screen size.
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(
        margin: EdgeInsets.only(
          top: SizeConfig.defaultSize * 10.0,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: SizeConfig.defaultSize * 2.0,
              ),
              child: Text(
                "Sign Up",
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
              controller: userNameController,
              label: 'User Name',
              hint: 'Enter your user name...',
              isSecure: false,
            ),
            Textfield(
              controller: passwordController,
              label: 'Password',
              hint: 'Enter your password...',
              isSecure: true,
            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.defaultSize * 2,
                left: SizeConfig.defaultSize,
              ),
              height: SizeConfig.defaultSize * 4,
              child: Row(
                children: [
                  Text(
                    'Image :',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                      color: MainFontsColor,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),
                  ButtonTheme(
                    minWidth: SizeConfig.defaultSize * 12,
                    height: SizeConfig.defaultSize * 3,
                    child: RaisedButton(
                      color: SubMainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        'Choose file',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blueGrey[900],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: chooseFile,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),
                  ButtonTheme(
                    minWidth: SizeConfig.defaultSize * 12,
                    height: SizeConfig.defaultSize * 3,
                    child: RaisedButton(
                      color: SubMainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        'Take picture',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blueGrey[900],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: takePicture,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: signUp,
        label: Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey[900],
          ),
        ),
        backgroundColor: SubMainColor,
        icon: Icon(
          Icons.person_add,
          color: Colors.blueGrey[900],
          size: 30.0,
        ),
      ),
    );
  }

  ///*****************************BACK END****************************************/
  //Text Editing Controllers to get data from Text Fields.
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  void titleDispose() {
    emailController.dispose();
    super.dispose();
  }

  void descriptionDispose() {
    userNameController.dispose();
    super.dispose();
  }

  void timeDispose() {
    passwordController.dispose();
    super.dispose();
  }

  //Method 'chooseFile' to make the user choose photo from device's gallary.
  Future chooseFile() async {
    final _picker = ImagePicker();
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
    });
    CustomRouter().navigator(
      context,
      Selection(
        picture: _image,
      ),
    );
  }

  //Method 'takePicture' to make the user choose photo from device's gallary.
  Future takePicture() async {
    final _picker = ImagePicker();
    PickedFile image = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
    CustomRouter().navigator(
      context,
      Selection(
        picture: _image,
      ),
    );
  }

  Future signUp() async {
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
      userNameController.clear();

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
      userNameController.clear();

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
      userNameController.clear();

      //Routing the user to 'Home Screen' and display loading spinner while routing.
    } else {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var uploadedImageUrl = prefs.getString('IMAGEURL');

        final newUser = await auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        prefs.setString('EMAIL', emailController.text);
        await fireStore
            .collection('Users')
            .doc(emailController.text.replaceAll(new RegExp(r"\s+\b|\b\s"), ""))
            .set({
          'Email': emailController.text,
          'User Name': userNameController.text,
          'Image': uploadedImageUrl,
        });
        if (newUser != null) {
          CustomRouter().navigator(context, Home());
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
