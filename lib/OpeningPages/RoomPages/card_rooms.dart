import 'package:flutter/material.dart';
import 'package:soft_proj/OpeningPages/RoomPages/room_details.dart';
import 'package:soft_proj/models/rooms.dart';
import './room_details.dart';

class RoomTile extends StatelessWidget {
  final List<RoomData> products;
  final int index;
  final String ghnameReq;

  RoomTile(this.products, this.index, this.ghnameReq);

  @override
  Widget build(BuildContext context) {
    return (products[index].gHouseName == ghnameReq)
        ? Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: FadeInImage(
                    image: NetworkImage(products[index].picLink),
                    placeholder: AssetImage('assets/imgLoading.jpg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Guest House: '+products[index].gHouseName,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Room No.: '+products[index].roomNo.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.info),
                            Text('Room Details')
                          ],
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RoomDetails(products[index]),
                            ),
                          ),
                        },
                      ),
                    ])
              ],
            ),
          )
        : Container();
  }
}
