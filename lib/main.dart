import 'package:flutter/material.dart';
import 'package:soft_proj/Login/setup/welcome.dart';
import 'package:soft_proj/Payment/payment.dart';
import 'package:soft_proj/Payment/postPayment.dart';
import './ScopedModels/mainmodel.dart';
import './OpeningPages/HousePages/view_ghouses.dart';
import './SideDrawerPages/profile.dart';
import 'package:scoped_model/scoped_model.dart';
import './OpeningPages/RoomPages/roomdata_page.dart';
import 'BookingPages/bookRooms.dart';
import 'BookingPages/dateSelect.dart';
import 'SideDrawerPages/bookings_done.dart';
import 'SideDrawerPages/hospitality.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel model = MainModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: model,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Oswald',
          ),
          routes: {
            '/': (BuildContext context) => WelcomePage(),
            '/bookings': (BuildContext context) => BookingPage(),
            '/guestHouse': (BuildContext context) => GHPage(model),
            '/profile': (BuildContext context) => UserProfilePage(),
            '/hosp': (BuildContext context) => Hospitality(),
            '/prof': (BuildContext context) => UserProfilePage(),
            '/dateSelect': (BuildContext context) => DateSelector(model),
            '/postPay': (BuildContext context) => postPay(model),
          },
          onGenerateRoute: (RouteSettings settings) {
            final List<String> inp = settings.name.split('/');

            if (inp[1] == '0') {
              return MaterialPageRoute(
                builder: (BuildContext context) => RoomDisp(model, inp[2]),
              );
            } else if (inp[1] == '1') {
              return MaterialPageRoute(
                builder: (BuildContext context) => RoomBookPage(model, inp[2]),
              );
            } else {
              return MaterialPageRoute(
                builder: (BuildContext context) => PayPage(model, inp[2]),
              );
            }
          },
        ));
  }
}
