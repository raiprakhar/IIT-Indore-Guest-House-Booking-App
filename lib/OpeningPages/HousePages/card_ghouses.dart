import 'package:flutter/material.dart';
import 'package:soft_proj/models/houses.dart';

class HouseTile extends StatelessWidget {
  final List<GuestHouses> products;
  final int index;

  HouseTile(this.products, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 18.0,
        clipBehavior: Clip.antiAlias,
        //color: Color.fromRGBO(213, 216, 233, 1),
        margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
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
                'Guest House: ' + products[index].guestHouseName,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                'Total Numer of Rooms: ' + products[index].noOfRoom.toString(),
                style: TextStyle(fontSize: 16),
              ),
            ),
            ButtonBar(alignment: MainAxisAlignment.center, children: <Widget>[
              FlatButton(
                child: Column(
                  children: <Widget>[Icon(Icons.info), Text('Details')],
                ),
                onPressed: () => {
                  Navigator.pushNamed(
                      context, '/0/' + products[index].guestHouseName),
                },
              ),
            ]),
          ],
        ));
  }
}
