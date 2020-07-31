import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:soft_proj/Login/setup/welcome.dart';
import 'package:soft_proj/ScopedModels/mainmodel.dart';
import './gh_disp_cards.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseUser loggedInUser;

class GHPage extends StatefulWidget {
  final MainModel model;
  GHPage(this.model);
  _GHPageState createState() => _GHPageState();
}

class _GHPageState extends State<GHPage> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();

    getCurrentUser();
    new Future.delayed(const Duration(seconds: 2));
    widget.model.fetchHouse();
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

  //_GHPageState();

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawerFunc(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Guest Houses'),
      ),
      floatingActionButton: Container(
        height: 130.0,
        width: 130.0,
        child: FittedBox(
          child: FloatingActionButton.extended(
              icon: Icon(Icons.add),
              backgroundColor: Colors.green,
              label: Text('Book Rooms'),
              onPressed: () {
                Navigator.pushNamed(context, '/dateSelect');
              }),
        ),
      ),
      body: _buildHouseList(),
    );
  }

  Widget _buildHouseList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(child: Text("No Guest Houses Found"));

      if (!model.isHouseLoading) {
        content = Column(
          children: <Widget>[
            Expanded(
              child: GHDispCards(),
            ),
          ],
        );
      } else {
        content = Center(child: CircularProgressIndicator());
      }

      return content;
    });
  }

  Widget _drawerFunc() {
    //String currUser = loggedInUser.email;
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("User"),
            accountEmail: Text("user@iiti.ac.in"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text('You'),
            ),
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(91, 100, 110, 1),
                    Color.fromRGBO(68, 131, 203, 1)
                  ]),
            ),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: new Text("Hospitality"),
              onTap: () {
                Navigator.pushNamed(context, '/hosp');
              }),
          ListTile(
              leading: Icon(Icons.shop),
              title: new Text("Bookings"),
              onTap: () {
                Navigator.pushNamed(context, '/bookings');
                //LEFT
              }),
          ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/prof');
              }),
          ListTile(
              leading: Icon(Icons.toc),
              title: new Text("About"),
              onTap: () {
                Navigator.pop(context);
                //LEFT
              }),
          ListTile(
              leading: Icon(Icons.help),
              title: new Text("Help"),
              onTap: () {
                Navigator.pop(context);
                //LEFT
              }),
          new Divider(),
          ListTile(
              leading: Icon(Icons.settings),
              title: new Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
              leading: Icon(Icons.power_settings_new),
              title: new Text("Logout"),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => WelcomePage()));
              }
              //LOGOUT

              )
        ],
      ),
    );
  }
}
