import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:customer_app/Components/Size_Configurations.dart';
import 'package:customer_app/Components/Constants.dart';
import 'package:customer_app/Components/Navigator.dart';
import 'package:customer_app/Screens/Sign_Up_Screen.dart';
import 'package:customer_app/Screens/Sign_In_Screen.dart';
import 'package:customer_app/Screens/Home_Screen.dart';

class MovieDetails extends StatefulWidget {
  MovieDetails({
    this.movieTitle,
    this.movieDescription,
    this.movieTime,
    this.movieImage,
    this.movieSeats,
    this.documentID,
  });
  final String movieTitle;
  final String movieDescription;
  final String movieTime;
  final String movieImage;
  final String documentID;
  final int movieSeats;
  @override
  _MovieDetailsState createState() => _MovieDetailsState(
        title: movieTitle,
        description: movieDescription,
        time: movieTime,
        image: movieImage,
        docID: documentID,
        seats: movieSeats,
      );
}

class _MovieDetailsState extends State<MovieDetails> {
  _MovieDetailsState({
    this.title,
    this.description,
    this.time,
    this.image,
    this.seats,
    this.docID,
  });
  final String title;
  final String description;
  final String time;
  final String image;
  final String docID;
  final int seats;

  @override
  Widget build(BuildContext context) {
    //Size Configurations to resize widgets according to screen size.
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: SubMainColor,
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.only(
                top: SizeConfig.defaultSize * 5,
                left: SizeConfig.defaultSize * 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            elevation: 10.0,
            child: Container(
              width: SizeConfig.defaultSize * 25.0,
              height: SizeConfig.defaultSize * 35.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.blueGrey[900],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // This will hold the Image in the back ground:
                  Container(
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      width: SizeConfig.defaultSize * 20.0,
                      height: SizeConfig.defaultSize * 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: SizeConfig.defaultSize,
              left: SizeConfig.defaultSize * 8.0,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontSize: 27.0,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: SizeConfig.defaultSize * 23.0,
            ),
            child: Text(
              'Story :',
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontSize: 24.0,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Container(
            width: SizeConfig.defaultSize * 30.0, //300.0,
            height: SizeConfig.defaultSize * 13.0, //130.0,
            child: Text(
              description,
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: SizeConfig.defaultSize * 30.0, //300.0,
            margin: EdgeInsets.only(
              top: SizeConfig.defaultSize * 3.0,
            ),
            child: Row(
              children: [
                Text(
                  'Time :',
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.defaultSize,
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: SizeConfig.defaultSize * 30.0, //300.0,
            margin: EdgeInsets.only(
              top: SizeConfig.defaultSize * 3.0,
            ),
            child: Row(
              children: [
                Text(
                  'Seats :',
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.defaultSize,
                ),
                Text(
                  seats.toString(),
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: bookSeat,
        backgroundColor: Colors.blueGrey[900],
        icon: Icon(
          Icons.add_circle_outline,
          color: SubMainColor,
          size: 30.0,
        ),
        label: Text(
          "Book a seat",
          style: AppBarLabeledBottomFontStyle,
        ),
      ),
    );
  }

  Future bookSeat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('EMAIL');
    email == null
        ? showDialog(
            context: context,
            child: AlertDialog(
              backgroundColor: Colors.blueGrey[900],
              elevation: 1.0,
              content: Text(
                'Sign in or Sign up to book movie seats',
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
                      CustomRouter().navigator(context, SignIn());
                    },
                  ),
                ),
              ],
            ))
        : CustomRouter().navigator(context, Home());
  }
}
