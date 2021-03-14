import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

Widget imagecarousel = Container(
  height: 200.0,
  margin: EdgeInsets.only(
    top: 10.0,
    right: 10.0,
    left: 10.0,
  ),
  child: Carousel(
    boxFit: BoxFit.cover,
    images: [
      AssetImage('assets/Carousel1.jpg'),
      AssetImage('assets/Carousel2.jpg'),
      AssetImage('assets/Carousel3.jpg'),
      AssetImage('assets/Carousel4.jpg'),
      AssetImage('assets/Carousel5.jpg'),
      AssetImage('assets/Carousel6.jpg'),
      AssetImage('assets/Carousel7.jpg'),
      AssetImage('assets/Carousel8.jpg'),
    ],
    showIndicator: false,
    autoplay: true,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 1000),
  ),
);
