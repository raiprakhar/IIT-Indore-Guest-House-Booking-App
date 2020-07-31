import 'package:scoped_model/scoped_model.dart';
import './guestHousesFuncs.dart';
import './roomFuncs.dart';
import 'bookingModel.dart';

class MainModel extends Model with GuestHouseModel, BookingModel, RoomModel, UtilityModelHouse, UtilityModelRoom{}