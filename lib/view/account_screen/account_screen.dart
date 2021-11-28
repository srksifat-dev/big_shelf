import 'package:big_shelf/controller/auth_controller.dart';
import 'package:big_shelf/view/account_screen/address_book.dart';
import 'package:big_shelf/view/account_screen/address_dialog.dart';
import 'package:big_shelf/view/account_screen/edit_account_dialog.dart';
import 'package:big_shelf/view/authentication/auth_view.dart';
import 'package:big_shelf/view/purchase_history/purchase_history.dart';
import 'package:big_shelf/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'account_item.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final authController = Get.find<AuthController>();

  bool loginStatus = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Info",
        ),
        backgroundColor: AppColors.green,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
                onTap: () => Get.offAll(() => AuthScreen()),
                child: Icon(Icons.logout)),
          )
        ],
      ),
      body:
          // ModalProgressHUD(
          //   color: LightColor.background,
          //   opacity: 1,
          //   progressIndicator: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(LightColor.customAmber,),),
          //   inAsyncCall: loginStatus,
          //         child:
          SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.percentWidth * 3),
                  color: AppColors.green.withOpacity(0.2),
                ),
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: context.percentWidth * 22,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: context.percentWidth * 65,
                              child: Text(
                                '${authController.name}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Text(
                            //   '@boiwalaa',
                            //   style: TextStyle(
                            //     color: LightColor.customBlack,
                            //     fontSize: 15,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () => showEditAccountDialog(context),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.green.withOpacity(0.5),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      5,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      Text(
                                        'Edit Account',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.03),
                      child: Column(
                        children: [
                          AccountItem(
                            screenWidth: screenWidth,
                            icon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            sectionTitle: 'Email: ',
                            valueText: '${authController.email}',
                          ),
                          SizedBox(
                            height: screenWidth * 0.03,
                          ),
                          AccountItem(
                            screenWidth: screenWidth,
                            icon: Icon(Icons.phone, color: Colors.black),
                            sectionTitle: 'Mobile: ',
                            valueText:
                                '${authController.contactNumber.toString()}',
                          ),
                          SizedBox(
                            height: screenWidth * 0.03,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenWidth * 0.03,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.green.withOpacity(0.2),
                    borderRadius:
                        BorderRadius.all(Radius.circular(screenWidth * 0.03))),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: authController.addressList.length == 0
                          ? () {
                              Fluttertoast.showToast(
                                  msg:
                                      "You didn't save your address! Please add your address.",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              showAddressDialog(context);
                            }
                          : () => Get.to(() => AddressBook()),
                      child: ProfileCustomCard(
                        title: "Address Book",
                        icon: Icon(Icons.location_city),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: ProfileCustomCard(
                        title: "Purchase History",
                        icon: Icon(Icons.history),
                      ),
                    ),
                    // Container(
                    //   height: 1,
                    //   width: double.infinity,
                    //   color: Colors.grey,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}

class ProfileCustomCard extends StatelessWidget {
  final Icon icon;
  final String title;

  const ProfileCustomCard({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 3),
      height: context.percentWidth * 15,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [icon, 15.widthBox, title.text.bold.xl.make()],
            ),
          ),
          Container(
            child: Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }
}
