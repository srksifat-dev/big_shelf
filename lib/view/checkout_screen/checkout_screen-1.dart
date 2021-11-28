// import 'dart:math';

// import 'package:animate_do/animate_do.dart';
// import 'package:big_shelf/controller/auth_view_controller.dart';
// import 'package:big_shelf/controller/cart_controller.dart';
// import 'package:big_shelf/controller/order_controller.dart';
// import 'package:big_shelf/model/cart.dart';
// import 'package:big_shelf/model/order.dart';
// import 'package:big_shelf/view/checkout_screen/select_delivery_option.dart';
// import 'package:big_shelf/view/theme/colors.dart';
// import 'package:country_state_city_pro/country_state_city_pro.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:velocity_x/velocity_x.dart';

// class CheckOutScreenNew extends StatelessWidget {
//   CheckOutScreenNew({Key? key}) : super(key: key);

//   final cartController = Get.find<CartController>();
//   final orderController = Get.find<OrderController>();
//   final authController = Get.find<AuthController>();
//   TextEditingController country = TextEditingController();
//   TextEditingController state = TextEditingController();
//   TextEditingController city = TextEditingController();

//   TextEditingController contactNumber = TextEditingController();
//   TextEditingController email = TextEditingController();

//   Object reDrawHomeScreen = "homeScreenKey";

//   String orderID() {
//     final length = 7;
//     final letterLowercase = "abcdefghijklmnopqrstuvwxyz";
//     final letterUppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//     final numbers = "0123456789";

//     String chars = "";
//     chars += "$letterLowercase$numbers$letterUppercase";
//     // chars += "$numbers";

//     return List.generate(length, (index) {
//       final indexRandom = Random.secure().nextInt(chars.length);

//       return chars[indexRandom];
//     }).join("");
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController name = TextEditingController()
//       ..text = "${authController.name}";
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           Positioned(
//             top: context.percentHeight * 27,
//             child: ElasticIn(
//               duration: Duration(milliseconds: 1000),
//               child: Container(
//                 height: context.percentHeight * 63,
//                 width: context.percentWidth * 90,
//                 decoration: BoxDecoration(
//                   color: AppColors.lightRed,
//                   borderRadius: BorderRadius.circular(context.percentWidth * 5),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     left: context.percentWidth * 5,
//                     right: context.percentWidth * 5,
//                     top: context.percentWidth * 6,
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         "Checkout Info".text.xl2.bold.make(),
//                         Form(
//                           child: Column(
//                             children: [
//                               TextFormField(
//                                 controller: name,
//                                 decoration: InputDecoration(
//                                   hintText: "Full Name",
//                                   filled: true,
//                                   fillColor: AppColors.deepRed.withOpacity(0.2),
//                                   contentPadding: EdgeInsets.symmetric(
//                                       horizontal: context.percentWidth * 5,
//                                       vertical: context.percentWidth * 3),
//                                   enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: AppColors.deepRed),
//                                   ),
//                                   focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: AppColors.deepRed),
//                                   ),
//                                 ),
//                               ),
//                               HeightBox(context.percentHeight * 1),
//                               TextFormField(
//                                 decoration: InputDecoration(
//                                   hintText: "Contact No.",
//                                   filled: true,
//                                   fillColor: AppColors.deepRed.withOpacity(0.2),
//                                   contentPadding: EdgeInsets.symmetric(
//                                       horizontal: context.percentWidth * 5,
//                                       vertical: context.percentWidth * 3),
//                                   enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: AppColors.deepRed),
//                                   ),
//                                   focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: AppColors.deepRed),
//                                   ),
//                                 ),
//                               ),
//                               HeightBox(context.percentHeight * 1),
//                               TextFormField(
//                                 decoration: InputDecoration(
//                                   hintText: "Email Address",
//                                   filled: true,
//                                   fillColor: AppColors.deepRed.withOpacity(0.2),
//                                   contentPadding: EdgeInsets.symmetric(
//                                       horizontal: context.percentWidth * 5,
//                                       vertical: context.percentWidth * 3),
//                                   enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: AppColors.deepRed),
//                                   ),
//                                   focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: AppColors.deepRed),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         HeightBox(context.percentHeight * 2),
//                         "Billing Address".text.xl2.bold.make(),
//                         CountryStateCityPicker(
//                           country: country,
//                           state: state,
//                           city: city,
//                           textFieldInputBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: AppColors.deepRed),
//                           ),
//                         ),
//                         HeightBox(context.percentHeight * 2),
//                         "Select Delivery Option".text.xl2.bold.make(),
//                         SelectDeliveryOption(),
//                         HeightBox(context.percentHeight * 2),
//                         Row(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(0),
//                               width: MediaQuery.of(context).size.width * 0.62,
//                               child: TextFormField(
//                                 decoration: InputDecoration(
//                                   hintText: "Promo Code",
//                                   filled: true,
//                                   fillColor: AppColors.deepRed.withOpacity(0.2),
//                                   contentPadding: EdgeInsets.symmetric(
//                                       horizontal: context.percentWidth * 5,
//                                       vertical: context.percentWidth * 3),
//                                   enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: AppColors.deepRed),
//                                   ),
//                                   focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: AppColors.deepRed),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Container(
//                                   height: context.percentHeight * 5.4,
//                                   decoration: BoxDecoration(
//                                       // borderRadius: BorderRadius.only(
//                                       //   topRight: Radius.circular(
//                                       //     context.percentWidth * 3,
//                                       //   ),
//                                       //   bottomRight: Radius.circular(
//                                       //     context.percentWidth * 3,
//                                       //   ),
//                                       //   topLeft: Radius.circular(
//                                       //     0,
//                                       //   ),
//                                       //   bottomLeft: Radius.circular(
//                                       //     0,
//                                       //   ),
//                                       // ),
//                                       color: AppColors.deepRed),
//                                   child: Center(
//                                     child: Text(
//                                       'Apply',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: context.percentWidth * 5,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   )),
//                             ),
//                           ],
//                         ),
//                         HeightBox(context.percentHeight * 2),
//                         Container(
//                           height: context.percentWidth * 50,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: AppColors.deepRed,
//                                 width: 2,
//                                 style: BorderStyle.solid),
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(context.percentWidth * 3),
//                             ),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding:
//                                     EdgeInsets.all(context.percentWidth * 3),
//                                 child: Container(
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             'Total: ',
//                                             style: TextStyle(
//                                               color: AppColors.deepRed,
//                                               fontSize:
//                                                   context.percentWidth * 4,
//                                             ),
//                                           ),
//                                           Text(
//                                             'Tk. ${cartController.sumCartPrice()}',
//                                             style: TextStyle(
//                                               color: AppColors.deepRed,
//                                               fontSize:
//                                                   context.percentWidth * 4,
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       Divider(
//                                         color: AppColors.deepRed,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             'Delivery Charge: ',
//                                             style: TextStyle(
//                                               color: AppColors.deepRed,
//                                               fontSize:
//                                                   context.percentWidth * 4,
//                                             ),
//                                           ),
//                                           Text(
//                                             'Tk.60',
//                                             style: TextStyle(
//                                               color: AppColors.deepRed,
//                                               fontSize:
//                                                   context.percentWidth * 4,
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       // Divider(
//                                       //   color: AppColors.deepRed,
//                                       // ),
//                                       // Row(
//                                       //   mainAxisAlignment:
//                                       //       MainAxisAlignment.spaceBetween,
//                                       //   children: [
//                                       //     Text(
//                                       //       'Gift Charge: ',
//                                       //       style: TextStyle(
//                                       //         color: AppColors.deepRed,
//                                       //         fontSize:
//                                       //             context.percentWidth * 4,
//                                       //       ),
//                                       //     ),
//                                       //     Text(
//                                       //       'Tk.100',
//                                       //       style: TextStyle(
//                                       //         color: AppColors.deepRed,
//                                       //         fontSize:
//                                       //             context.percentWidth * 4,
//                                       //       ),
//                                       //     )
//                                       //   ],
//                                       // ),
//                                       Divider(
//                                         color: AppColors.deepRed,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             'Promo Code Discount: ',
//                                             style: TextStyle(
//                                               color: AppColors.deepRed,
//                                               fontSize:
//                                                   context.percentWidth * 4,
//                                             ),
//                                           ),
//                                           Text(
//                                             '-Tk.0',
//                                             style: TextStyle(
//                                               color: AppColors.deepRed,
//                                               fontSize:
//                                                   context.percentWidth * 4,
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                       Divider(
//                                         color: AppColors.deepRed,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             'Payable Total: ',
//                                             style: TextStyle(
//                                               color: AppColors.deepRed,
//                                               fontSize:
//                                                   context.percentWidth * 4,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           Text(
//                                             'Tk.1000',
//                                             style: TextStyle(
//                                               color: AppColors.deepRed,
//                                               fontSize:
//                                                   context.percentWidth * 4,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               // Container(
//                               //   decoration: BoxDecoration(
//                               //     borderRadius: BorderRadius.only(
//                               //         bottomRight: Radius.circular(context.percentWidth * 2),
//                               //         bottomLeft: Radius.circular(context.percentWidth * 2)),
//                               //     color: LightColor.customAmber,
//                               //   ),
//                               //   height:context.percentWidth * 11,
//                               //   child: Row(
//                               //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               //     children: [
//                               //       GestureDetector(
//                               //         onTap: () => Get.to(GiftShipmentInfoScreen()),
//                               //         child: Container(
//                               //           child: Center(
//                               //             child: Text(
//                               //               'Continue to Gift',
//                               //               style: TextStyle(
//                               //                 fontWeight: FontWeight.bold,
//                               //                 color: AppColors.deepRed,
//                               //                 fontSize: context.percentWidth * 5,
//                               //               ),
//                               //             ),
//                               //           ),
//                               //         ),
//                               //       ),
//                               //       VerticalDivider(
//                               //         color: AppColors.deepRed,
//                               //         thickness: 2,
//                               //       ),
//                               //       GestureDetector(
//                               //         onTap: () => Get.to(ShipmentInfoScreen()),
//                               //         child: Container(
//                               //           child: Center(
//                               //             child: Text(
//                               //               'Continue to Next',
//                               //               style: TextStyle(
//                               //                 fontWeight: FontWeight.bold,
//                               //                 color: AppColors.deepRed,
//                               //                 fontSize: context.percentWidth * 5,
//                               //               ),
//                               //             ),
//                               //           ),
//                               //         ),
//                               //       ),
//                               //     ],
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                         ),
//                         HeightBox(context.percentHeight * 2),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             hintText: "Transaction ID(Bkash/Rocket/Nagad) ",
//                             filled: true,
//                             fillColor: AppColors.deepRed.withOpacity(0.2),
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: context.percentWidth * 5,
//                                 vertical: context.percentWidth * 3),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: AppColors.deepRed),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: AppColors.deepRed),
//                             ),
//                           ),
//                         ),
//                         HeightBox(context.percentHeight * 1),
//                         "* Send Money to Bkash personal(01620535560)/ Rocket personal(01620535560)/ Nagad personal(01620535560)"
//                             .text
//                             .gray500
//                             .make(),
//                         HeightBox(context.percentHeight * 8),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//               bottom: context.percentHeight * 10,
//               left: context.percentWidth * 5,
//               right: context.percentWidth * 5,
//               child: ElasticIn(
//                 duration: Duration(milliseconds: 1000),
//                 child: GestureDetector(
//                   onTap: () {
//                     Get.back();
//                     reDrawHomeScreen = Object();
//                     cartController.cart.clear();
//                     cartController.cart.refresh();
//                     Fluttertoast.showToast(
//                         msg:
//                             "Your order has been placed. Wait behind the door to get it!",
//                         toastLength: Toast.LENGTH_LONG,
//                         gravity: ToastGravity.CENTER,
//                         timeInSecForIosWeb: 1,
//                         // backgroundColor: AppColors.deepRed,
//                         textColor: Colors.white,
//                         fontSize: 16.0);
//                   },
//                   child: Container(
//                       decoration: BoxDecoration(
//                           color: AppColors.deepRed,
//                           borderRadius: BorderRadius.circular(
//                             context.percentWidth * 5,
//                           )),
//                       height: context.percentWidth * 14,
//                       width: context.percentWidth * 90,
//                       child: TextButton(
//                           onPressed: () async {
//                             final List<CartItem> orders = [];
//                             final f = DateFormat("yyyy-MM-dd hh:mm");
//                             final dateTime = f.format(DateTime.now());
//                             for (CartItem cartItem in cartController.cart) {
//                               orders.add(cartItem);
//                             }
//                             final orderItem = OrderItem(
//                               totalPrice: cartController.sumCartPrice(),
//                               orderID: "BO#${orderID()}",
//                               cartItem: orders,
//                               orderTime: dateTime,
//                             );
//                             orderController.addOrder(orderItem);

//                             Get.back();
//                             reDrawHomeScreen = Object();
//                             cartController.cart.clear();
//                             cartController.cart.refresh();
//                             Fluttertoast.showToast(
//                                 msg:
//                                     "Your order has been placed. Wait behind the door to get it!",
//                                 toastLength: Toast.LENGTH_LONG,
//                                 gravity: ToastGravity.CENTER,
//                                 timeInSecForIosWeb: 1,
//                                 // backgroundColor: AppColors.deepRed,
//                                 textColor: Colors.white,
//                                 fontSize: 16.0);
//                           },
//                           child: "Confirm Order"
//                               .text
//                               .color(AppColors.backgroundWhite)
//                               .xl2
//                               .makeCentered())),
//                 ),
//               )),
//           Positioned(
//             bottom: context.percentHeight * 3,
//             child: ElasticIn(
//               duration: Duration(milliseconds: 1000),
//               child: GestureDetector(
//                 onTap: () => Get.back(),
//                 child: CircleAvatar(
//                   backgroundColor: Colors.white.withOpacity(0.5),
//                   radius: 20,
//                   child: Center(
//                     child: Icon(
//                       Icons.close,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
