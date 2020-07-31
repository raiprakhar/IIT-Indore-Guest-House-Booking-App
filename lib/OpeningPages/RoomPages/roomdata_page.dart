import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:soft_proj/ScopedModels/mainmodel.dart';
import './room_disp_cards.dart';

class RoomDisp extends StatefulWidget {
  final MainModel model;
  final String ghname;
  RoomDisp(this.model, this.ghname);
    @override
  _RoomDispState createState() => _RoomDispState();
}

class _RoomDispState extends State<RoomDisp> {

  String ghnameReq;


  @override
  void initState() {
    this.ghnameReq=widget.ghname;
    widget.model.fetchRoom();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true ,title: Text('Guest House: '+ghnameReq)),
      body: _buildRoomList(),
      
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


   Widget _buildRoomList (){
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model){
        Widget content = Center(child: Text("No Rooms Found"));

      if(!model.isRoomLoading){

        content = Column(
        children: <Widget>[
          Expanded(
            child: RoomDispCards(ghnameReq),
          ),
        ],
      );

      }
      else{
        content = Center(child: CircularProgressIndicator());
      }

      return content;

    });
  }


}

