import 'package:flutter/material.dart';

class RoomData{

  final String roomID;
  final String bookedBy;
  final String bookedOn;
  final String gHouseName;
  final int roomNo;
  final int floorNo;
  final bool availability;
  final String bookedFrom;
  final String bookedUpto;
  final String picLink;
  final int price;

  RoomData({
    @required this.roomID,
    @required this.bookedBy,
    @required this.bookedOn,
    @required this.gHouseName,
    @required this.roomNo,
    @required this.floorNo,
    @required this.availability,
    @required this.bookedFrom,
    @required this.bookedUpto,
    @required this.picLink,
    @required this.price
  });

}