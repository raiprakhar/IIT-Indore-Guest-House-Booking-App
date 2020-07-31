import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/rooms.dart';
import '../ScopedModels/mainmodel.dart';

import 'package:fluttertoast/fluttertoast.dart';

class RoomBookPage extends StatefulWidget {
  final MainModel model;
  final String noOfDays;
  RoomBookPage(this.model, this.noOfDays);

  @override
  _RoomBookPageState createState() => _RoomBookPageState();
}

class _RoomBookPageState extends State<RoomBookPage> {
  List<bool> inputs = new List<bool>();
  String noOfdayStay;

  int price = 0;

  void changePrice(int currprice, bool opr) {
    if (opr) {
      price += currprice;
    } else {
      price -= currprice;
    }
  }

  @override
  void initState() {
    noOfdayStay = widget.noOfDays;
    widget.model.fetchRoom();
    super.initState();
  }

  void ItemChange(bool val, int index) {
    setState(() {
      inputs[index] = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: new Scaffold(
          appBar: new AppBar(
            centerTitle: true,
            title: new Text('Select Rooms'),
          ),
          body: _bodyCode(),
          floatingActionButton: Container(
            height: 170.0,
            width: 170.0,
            child: FittedBox(
              child: FloatingActionButton.extended(
                  icon: Icon(Icons.forward),
                  backgroundColor: Colors.green,
                  label: Text('Proceed to Payment'),
                  onPressed: () {
                    price = price * int.parse(noOfdayStay);
                    if (price == 0) {
                      Fluttertoast.showToast(
                          msg: 'You Have selected 0 Rooms.',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Navigator.pushReplacementNamed(
                          context, '/2/' + price.toString());
                    }
                  }),
            ),
          ),
        ));
  }

  Widget _bodyCode() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(child: Text("No Rooms Found"));

        if (!model.isRoomLoading) {
          setInputfalse(model.productsRoom);
          content = Column(
            children: <Widget>[
              Flexible(
                child: _buildRoomList(model.productsRoom),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                  child: Text('You have opted for booking for ' +
                      noOfdayStay +
                      ' days.'),
                ),
              ),
            ],
          );
        } else {
          content = Center(child: CircularProgressIndicator());
        }

        return content;
      },
    );
  }

  Widget _buildRoomList(List<RoomData> products) {
    Widget productCard;

    if (products.length > 0) {
      productCard = ListView.builder(
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) => new Card(
          child: new Container(
            padding: new EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                new CheckboxListTile(
                    value: inputs[index],
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Column(children: <Widget>[
                              Text(
                                'Guest House- ' + products[index].gHouseName,
                                style: TextStyle(fontFamily: 'Roboto'),
                              ),
                              Text(
                                'Room No.- ' +
                                    products[index].roomNo.toString(),
                                style: TextStyle(fontFamily: 'Roboto'),
                              ),
                            ]),
                          ),
                          Text(
                            'Price- Rs. ' + products[index].price.toString(),
                            style: TextStyle(fontFamily: 'Roboto'),
                          )
                        ]), //
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: products[index].availability
                        ? (bool val) {
                            ItemChange(val, index);
                            changePrice(products[index].price, val);
                            widget.model.updateRoomBooked(index, val);
                          }
                        : null)
              ],
            ),
          ),
        ),
      );
    } else {
      productCard = Center(child: Text('No Rooms Found'));
    }

    return productCard;
  }

  void setInputfalse(List<RoomData> products) {
    for (int i = 0; i < products.length; i++) {
      inputs.add(false);
    }
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Confirm Dialog Box'),
            content: new Text('Do you want to go back?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Discard"),
              ),
              SizedBox(height: 16),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.model.clearRoomIds();
                  Navigator.pop(context);
                },
                child: Text("Confirm"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
