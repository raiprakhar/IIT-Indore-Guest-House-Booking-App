import 'package:flutter/material.dart';

class Users{

  final String uID;
  final String emailID;
  final String password;
  final String name;
  final DateTime DOB;
  final String phNo;
  final String picLink;


  Users({
    @required this.uID,
    @required this.emailID,
    @required this.password,
    @required this.name,
    @required this.DOB,
    @required this.phNo,
    @required this.picLink,
  });

}