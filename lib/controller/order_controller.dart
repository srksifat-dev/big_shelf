import 'package:big_shelf/model/cart.dart';
import 'package:big_shelf/model/order.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var orderList = List<OrderItem>.empty(growable: true).obs;
  DeliveryMethod deliveryMethod = DeliveryMethod.cod;
  DeliveryPlace deliveryPlace = DeliveryPlace.inside;
  // var deliveryCost = 0.obs;
  // var orders = List<CartItem>.empty(growable: true).obs;

  int sumOrderPrice(List<CartItem> cartList) {
    return cartList.fold(
        0,
        (previousValue, element) =>
            previousValue + element.book.discountedPrice * element.quantity);
  }

  int deliveryCharge(DeliveryPlace deliveryPlace, DeliveryMethod method) {
    return method == DeliveryMethod.cod
        ? deliveryPlace == DeliveryPlace.inside
            ? 60
            : 100
        : 50;
  }

  // int sumOrderQuantity() {
  //   return orderList.fold(
  //       0, (previousValue, element) => previousValue + element.quantity);
  // }

  // RxInt cartItemQuantity(OrderItem orderItem) {
  //   return orderItem.quantity.obs;
  // }

  // void addProductIntoOrderList(CartItem cartItem) {
  //   orders.add(cartItem);
  // }

  void addOrder(OrderItem orderItem) {
    orderList.add(orderItem);
  }
}
