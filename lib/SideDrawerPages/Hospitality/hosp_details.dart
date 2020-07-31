import 'package:flutter/material.dart';
import './util/categories.dart';
import './util/friends.dart';
import './util/restaurants.dart';
import './util/recreation.dart';
import './util/transport.dart';
import './util/essentials.dart';
import './widgets/slide_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  final TextEditingController _searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: PreferredSize(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
          child: Card(
            elevation: 6.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(9.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Search...",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  suffixIcon: Icon(
                    Icons.filter_list,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
              ),
            ),
          ),
        ),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          120.0,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),

            Wrap(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Category",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.0),

            //Horizontal List here
            Container(
              height: MediaQuery.of(context).size.height / 5,
              child: ListView.builder(
                primary: false,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories == null ? 0 : categories.length,
                itemBuilder: (BuildContext context, int index) {
                  Map cat = categories[index];

                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            cat["img"],
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.height / 5,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                // Add one stop for each color. Stops should increase from 0 to 1
                                stops: [0.2, 0.7],
                                colors: [
                                  cat['color1'],
                                  cat['color2'],
                                ],
                                // stops: [0.0, 0.1],
                              ),
                            ),
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.height / 5,
                          ),
                          Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.height / 6,
                              padding: EdgeInsets.all(1),
                              constraints: BoxConstraints(
                                minWidth: 20,
                                minHeight: 20,
                              ),
                              child: Center(
                                child: Text(
                                  cat["name"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Trending in Restaurants",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.0),

            Container(
              height: MediaQuery.of(context).size.height / 2.4,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: restaurants == null ? 0 : restaurants.length,
                itemBuilder: (BuildContext context, int index) {
                  Map restaurant = restaurants[index];

                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: SlideItem(
                      img: restaurant["img"],
                      title: restaurant["title"],
                      address: restaurant["address"],
                      rating: restaurant["rating"],
                    ),
                  );
                },
              ),
            ),

            //Horizontal List here

            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Trending in Essentials ",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),

            SizedBox(height: 15.0),

            Container(
              height: MediaQuery.of(context).size.height / 2.4,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: essentials == null ? 0 : essentials.length,
                itemBuilder: (BuildContext context, int index) {
                  Map essential = essentials[index];

                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: SlideItem(
                      img: essential["img"],
                      title: essential["title"],
                      address: essential["address"],
                      rating: essential["rating"],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 30.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Trending in Recreation ",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.0),

            Container(
              height: MediaQuery.of(context).size.height / 2.4,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: recreation == null ? 0 : recreation.length,
                itemBuilder: (BuildContext context, int index) {
                  Map rec = recreation[index];

                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: SlideItem(
                      img: rec["img"],
                      title: rec["title"],
                      address: rec["address"],
                      rating: rec["rating"],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Trending in Transport ",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.0),

            Container(
              height: MediaQuery.of(context).size.height / 2.4,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: transport == null ? 0 : transport.length,
                itemBuilder: (BuildContext context, int index) {
                  Map rec = transport[index];

                  return Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: SlideItem(
                      img: rec["img"],
                      title: rec["title"],
                      address: rec["address"],
                      rating: rec["rating"],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 40.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Contacts",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.0),

            Container(
              height: 60.0,
              child: ListView.builder(
                primary: false,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: friends == null ? 0 : friends.length,
                itemBuilder: (BuildContext context, int index) {
                  String img = friends[index];

                  return Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        img,
                      ),
                      radius: 45.0,
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
