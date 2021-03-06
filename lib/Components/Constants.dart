//Import necessary packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///*************************COLORS**************************/
const MainColor = Color(0xFF4b0082);
const SubMainColor = Color(0xFFffc045);
const MainFontsColor = Color(0xFFffc045);
const SubFontsColor = Color(0xFFffffff);

///*******************SEATS COLORS*****************************/
const BookedSeatColor = Color(0xFFf41606);
const AvailableSeatColor = Color(0xFF4da602);
const FreeSeatColor = Color(0xFFffffff);
const YourReservedSeatsColor = Color(0xFF868981);

///*************************App Bar Text Style**************************/
const AppBarFontStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
  color: MainFontsColor,
);

const AppBarLabeledBottomFontStyle = TextStyle(
  fontSize: 17.0,
  fontWeight: FontWeight.w500,
);

const AppBarUnLabeledBottomFontStyle = TextStyle(
  fontSize: 16.0,
);

///*************************Movies Label Text Style**************************/
const MoviesLabelFontStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w800,
  fontStyle: FontStyle.italic,
);

///*************************Movies Label Text Style**************************/
const HomeLabelFontStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w900,
  fontStyle: FontStyle.italic,
  color: MainFontsColor,
);

///*************************Hint Label Text Style**************************/

///*************************Hint Label Text Style**************************/
const HintLabelFontStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w800,
  fontStyle: FontStyle.italic,
  color: MainFontsColor,
);

///*************************Movies Card Decoration**************************/
const MoviesCardDecoration = BoxDecoration(color: SubMainColor, boxShadow: [
  BoxShadow(
    blurRadius: 2.5,
    spreadRadius: 1.0,
    offset: Offset(
      0,
      2.0,
    ),
  )
]);
