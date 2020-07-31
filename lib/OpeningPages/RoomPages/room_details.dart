import 'package:flutter/material.dart';
import 'package:soft_proj/models/rooms.dart';

class RoomDetails extends StatelessWidget {
  final RoomData recProduct;
  RoomDetails(this.recProduct);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(centerTitle: true,
        title: Text('Room Details'),
        ),


      body: Container(
        padding: EdgeInsets.fromLTRB(2, 10, 2, 0),
        child: Column(
          children: <Widget>[

            Padding(
                  padding: EdgeInsets.all(8),
                  child: FadeInImage(
                    image: NetworkImage(recProduct.picLink),
                    placeholder: AssetImage('assets/imgLoading.jpg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Guest House Name: '+recProduct.gHouseName,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Room No.: '+recProduct.roomNo.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Floor: '+recProduct.floorNo.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Price: Rs. '+recProduct.price.toString()+' per Night',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Text(
                    'Available: ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    (recProduct.availability==true)?"Yes":"No",
                    style: TextStyle(fontSize: 18),
                  ),
                  ],)
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
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RoomDetails(recProduct),),),
                        },
                      ),
                    ],),

          ],
        ),
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
    );
  }

}