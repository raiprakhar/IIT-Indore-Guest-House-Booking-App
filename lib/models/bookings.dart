import 'package:flutter/material.dart';

class Bookings{

  final String emailID;
  final DateTime dateOfBooking;
  final DateTime bookedFrom;
  final DateTime bookedUpto;
  //final String roomID;


  Bookings({
    @required this.emailID,
    @required this.dateOfBooking,
    @required this.bookedFrom,
    @required this.bookedUpto,
    //@required this.roomID,
  });

}