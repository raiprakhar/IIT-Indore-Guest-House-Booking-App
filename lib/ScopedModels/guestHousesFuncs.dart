import 'package:scoped_model/scoped_model.dart';
import '../models/houses.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GuestHouseModel extends Model {
  List<GuestHouses> _guesthouses;
  bool _isHouseLoading = false;

  void fetchHouse() {
    _isHouseLoading = true;

    http
        .get('https://cs258-project.firebaseio.com/AllFolders/GuestHouses.json')
        .then((http.Response response) {
      final Map<String, dynamic> gbhListData = json.decode(response.body);
      final List<GuestHouses> fetchedGBList = [];

      gbhListData.forEach(
        (String houseIDobt, dynamic ghData) {
          final GuestHouses ghInit = GuestHouses(
            houseID: houseIDobt,
            guestHouseName: ghData['guestHouseName'],
            noOfRoom: ghData['noOfRoom'],
            bookedRoom: ghData['bookedRoom'],
            picLink: ghData['picLink'],
          );

          fetchedGBList.add(ghInit);
        },
      );

      _guesthouses = fetchedGBList;

      _isHouseLoading = false;
      notifyListeners();
    });
  }

  List<GuestHouses> get products {
    return List.from(_guesthouses);
  }

  void updateHouse(int index, GuestHouses houseDetails) {
    _guesthouses[index] = houseDetails;
  }
}

class UtilityModelHouse extends GuestHouseModel {
  bool get isHouseLoading {
    return _isHouseLoading;
  }
}
