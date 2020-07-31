import 'package:scoped_model/scoped_model.dart';
import '../models/rooms.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel extends Model {
  List<RoomData> _roomDet = [];
  bool _isRoomLoading = false;
  final _firestore = Firestore.instance;

  void fetchRoom() {
    _isRoomLoading = true;
    http
        .get('https://cs258-project.firebaseio.com/AllFolders/Rooms.json')
        .then((http.Response response) {
      final Map<String, dynamic> roomListData = json.decode(response.body);
      final List<RoomData> fetchedRoomList = [];

      roomListData.forEach(
        (String roomIDobt, dynamic roomData) {
          final RoomData roomInit = RoomData(
              roomID: roomIDobt,
              bookedBy: roomData['bookedBy'],
              bookedOn: roomData['bookedOn'],
              gHouseName: roomData['gHouseName'],
              roomNo: roomData['roomNo'],
              floorNo: roomData['floorNo'],
              availability: roomData['availability'],
              bookedFrom: roomData['bookedFrom'],
              bookedUpto: roomData['bookedUpto'],
              picLink: roomData['picLink'],
              price: roomData['price']);
          fetchedRoomList.add(roomInit);
        },
      );

      _roomDet = fetchedRoomList;
      _isRoomLoading = false;
      notifyListeners();
    });
  }

  void updateRoom(int index, bool avail, String email, String bookOn,
      String bookedFro, String bookedTo) async {
    _isRoomLoading = true;
    String storeId = _roomDet[index].roomID;

    Map<String, dynamic> roomUpdateData = {
      'availability': avail,
      'bookedBy': email,
      'bookedFrom': bookedFro,
      'bookedOn': bookOn,
      'bookedUpto': bookedTo,
      'floorNo': _roomDet[index].floorNo,
      'gHouseName': _roomDet[index].gHouseName,
      'picLink': _roomDet[index].picLink,
      'price': _roomDet[index].price,
      'roomNo': _roomDet[index].roomNo,
    };
    print(storeId);
    await http.put(
        'https://cs258-project.firebaseio.com/AllFolders/Rooms/${storeId}.json',
        body: json.encode(roomUpdateData));

    RoomData temp = RoomData(
      availability: avail,
      bookedBy: email,
      bookedFrom: bookedFro,
      bookedOn: bookOn,
      bookedUpto: bookedTo,
      floorNo: _roomDet[index].floorNo,
      gHouseName: _roomDet[index].gHouseName,
      picLink: _roomDet[index].picLink,
      price: _roomDet[index].price,
      roomID: _roomDet[index].roomID,
      roomNo: _roomDet[index].roomNo,
    );

    _roomDet[index] = temp;

    _isRoomLoading = false;

    notifyListeners();
  }

  void bookingDetails(int index, bool avail, String email, String bookOn,
      String bookedFro, String bookedTo) async {
    // String storeId = _roomDet[index].roomID;
    _isRoomLoading = true;
    Map<String, dynamic> roomUpdateData = {
      'availability': avail,
      'bookedBy': email,
      'bookedFrom': bookedFro,
      'bookedOn': bookOn,
      'bookedUpto': bookedTo,
      'floorNo': _roomDet[index].floorNo,
      'gHouseName': _roomDet[index].gHouseName,
      'picLink': _roomDet[index].picLink,
      'price': _roomDet[index].price,
      'roomNo': _roomDet[index].roomNo,
    };
    await _firestore.collection('bookings').add(roomUpdateData);
    // await _firestore
    //     .collection('bookings')
    //     .document()
    //     .updateData(roomUpdateData);
    // _isRoomLoading = false;
    notifyListeners();
  }

  List<RoomData> get productsRoom {
    return List.from(_roomDet);
  }
}

class UtilityModelRoom extends RoomModel {
  bool get isRoomLoading {
    return _isRoomLoading;
  }
}
