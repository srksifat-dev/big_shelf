import 'package:animate_do/animate_do.dart';
import 'package:big_shelf/controller/cart_controller.dart';
import 'package:big_shelf/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class DetailBottomSheet extends StatelessWidget {
  final controller = Get.find<CartController>();
  DetailBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        // initialChildSize: 1,
        // minChildSize:1,
        // maxChildSize: 1,
        expand: true,
        builder: (context, scrollController) {
          return SingleChildScrollView(physics: BouncingScrollPhysics(),
            controller: scrollController,
            child: Container(
              height: context.percentHeight * 100,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    child: "Cart".text.white.make(),
                  ),
                  20.heightBox,
                  Obx(
                    () => Container(
                      height: context.percentHeight * 80,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.cart.length,
                          itemBuilder: (context, index) {
                            final cartItem = controller.cart[index];
                            return Image.asset(
                              cartItem.book.image,
                              height: 20,
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
