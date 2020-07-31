import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:soft_proj/ScopedModels/mainmodel.dart';
import 'package:soft_proj/models/rooms.dart';
import './card_rooms.dart';

class RoomDispCards extends StatelessWidget {

  final String ghNameReq;
  RoomDispCards(this.ghNameReq);


  Widget _buildProductList(List<RoomData> products) {

    Widget productCard;

    if(products.length > 0){
       productCard = ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) => RoomTile(products, index, ghNameReq),
          );
    }
    else{
        productCard = Center(child: Text('No Guest Houses Found'));
    }

    return productCard;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildProductList(model.productsRoom);
      },
    );
}
}