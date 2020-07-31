import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Hospitality/hosp_details.dart';
import './Hospitality/util/consts.dart';

class Hospitality extends StatefulWidget {
  @override
  _HospState createState() => _HospState();
}

class _HospState extends State<Hospitality> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDark ? Constants.darkPrimary : Constants.lightPrimary,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: isDark ? Constants.darkTheme : Constants.lightTheme,
      home: Home(),
    );
  }
}
