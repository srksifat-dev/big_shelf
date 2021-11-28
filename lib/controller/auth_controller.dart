import 'package:big_shelf/model/address.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var addressList = List<Address>.empty(growable: true).obs;

  var name = "BIG Shelf";
  var email = "yourEmail@example.com";
  var password = "";
  var contactNumber = "01*********";
}
