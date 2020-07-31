import 'package:flutter/material.dart';

class GuestHouses{

  final String houseID;
  final String guestHouseName;
  final int noOfRoom;
  final int bookedRoom; //NOT USED ANYWHERE
  final String picLink;

  GuestHouses({
    @required this.houseID,
    @required this.guestHouseName,
    @required this.noOfRoom,
    @required this.bookedRoom,
    @required this.picLink,
  });

}