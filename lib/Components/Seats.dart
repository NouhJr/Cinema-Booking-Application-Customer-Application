import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/Components/Constants.dart';

// ignore: must_be_immutable
class Seat extends StatefulWidget {
  Seat({
    this.selectedSeatID,
    this.isReserved,
    this.movieDOC,
  });
  bool isSelected = false;
  bool isReserved = false;
  int selectedSeatID;
  String movieDOC;

  @override
  _CienmaSeatState createState() => _CienmaSeatState();
}

class _CienmaSeatState extends State<Seat> {
  List<dynamic> ids = [];
  int index;
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        final doc =
            await fireStore.collection('Movies').doc(widget.movieDOC).get();
        List<dynamic> tempids = doc['Selected IDs'];
        int tempindex = doc['Selected IDs Index'];
        setState(() {
          ids = tempids;
          index = tempindex;
        });
        if (!widget.isReserved) {
          widget.isSelected = !widget.isSelected;
          if (widget.isSelected) {
            ids.insert(index + 1, widget.selectedSeatID);
            await fireStore.collection('Movies').doc(widget.movieDOC).update({
              'Selected IDs Index': index + 1,
              'Selected IDs': ids,
            });
          } else {
            ids.removeLast();
            await fireStore.collection('Movies').doc(widget.movieDOC).update({
              'Selected IDs Index': index - 1,
              'Selected IDs': ids,
            });
          }
        } else {
          // ignore: unnecessary_statements
          null;
        }
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
          width: MediaQuery.of(context).size.width / 15,
          height: MediaQuery.of(context).size.width / 15,
          decoration: BoxDecoration(
              color: widget.isSelected && !widget.isReserved
                  ? AvailableSeatColor
                  : widget.isReserved
                      ? BookedSeatColor
                      : FreeSeatColor,
              borderRadius: BorderRadius.circular(5.0))),
    );
  }
}
