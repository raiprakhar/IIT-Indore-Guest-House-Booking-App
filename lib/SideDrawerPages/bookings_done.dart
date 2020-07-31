import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    new Future.delayed(const Duration(seconds: 2));
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bookings'),
      ),
      body: SafeArea(child: Expanded(child: BookingsStream())),
    );
  }
}

class BookingsStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('bookings').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents;
        List<BookingsBubble> bookingsBubbles = [];
        for (var message in messages) {
          final bookedBy = message.data['bookedBy'];
          final bookedOn = message.data['bookedOn'];
          final bookedFrom = message.data['bookedFrom'];
          final bookedUpto = message.data['bookedUpto'];
          final gHouseName = message.data['gHouseName'];
          final price = message.data['price'];
          final roomNo = message.data['roomNo'];

          final currentUser = loggedInUser.email;

          final bookingBubble = BookingsBubble(
            bookedBy,
            bookedFrom,
            bookedUpto,
            bookedOn,
            gHouseName,
            roomNo,
            price,
          );
          if (currentUser == bookedBy) {
            bookingsBubbles.add(bookingBubble);
          }
        }
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: bookingsBubbles,
        );
      },
    );
  }
}

class BookingsBubble extends StatelessWidget {
  final String bookedFrom;
  final String bookedUpto;
  final String bookedOn;
  final String bookedBy;
  final String gHouseName;
  final int roomNo;
  final int price;

  BookingsBubble(this.bookedBy, this.bookedFrom, this.bookedUpto, this.bookedOn,
      this.gHouseName, this.roomNo, this.price);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[400],
          borderRadius: BorderRadius.circular(17),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Booked By: " + bookedBy,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Booked From: " + bookedFrom,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Booked Upto: " + bookedUpto,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Booked On: " + bookedOn,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Guest House: " + gHouseName,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Room No: " + roomNo.toString(),
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Price: Rs" + price.toString(),
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
