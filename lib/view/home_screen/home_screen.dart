import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:badges/badges.dart';
import 'package:big_shelf/controller/auth_controller.dart';
import 'package:big_shelf/controller/messaage_controller.dart';
import 'package:big_shelf/controller/order_controller.dart';
import 'package:big_shelf/model/book.dart';
import 'package:big_shelf/view/cart_bottomSheet/animated_count.dart';
import 'package:big_shelf/view/cart_bottomSheet/cart_bottomSheet-1.dart';
import 'package:big_shelf/controller/cart_controller.dart';
import 'package:big_shelf/view/detail_screen/detail_screen.dart';
import 'package:big_shelf/view/home_screen/drawer.dart';
import 'package:big_shelf/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final cartController = Get.put(CartController());
  final orderController = Get.put(OrderController());
  final messageController = Get.put(MessageController());
  final authController = Get.find<AuthController>();

  late AnimationController _animationController;
  Object reDrawObject = "reDraw";
  Object reDrawHomeScreen = "homeScreenKey";
  DateTime? lastPressed;
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  final _controller = PageController();
  final _notifierScroll = ValueNotifier(0.0);
  List<String> finalPublicationList = [];

  List<String> finalCategoryList = [];

  late List<Book> queryBooks;

  late List<String> queryCategoryList;

  late List<String> queryPublicationList;

  String query = "";

  Color categoryBadgeColor = AppColors.deepRed.withOpacity(0.5);

  Color publicationBadgeColor = AppColors.deepRed.withOpacity(0.5);

  Color _toggleBadgeColorOfPublicationList(String item) {
    // setState(() {
    for (String newItem in queryPublicationList) {
      if (newItem == item) {
        return AppColors.green.withOpacity(0.5);
      }
    }
    return AppColors.mediumRed;
    // });
  }

  Color _toggleBadgeColorOfCategoryList(String item) {
    // setState(() {
    for (String newItem in queryCategoryList) {
      if (newItem == item) {
        return AppColors.green.withOpacity(0.5);
      }
    }
    return AppColors.mediumRed;
    // });
  }

  void _listener() {
    _notifierScroll.value = _controller.page!;
  }

  @override
  void initState() {
    _controller.addListener(_listener);
    searchController.addListener(() => setState(() {}));
    queryBooks = [];
    queryCategoryList = [];
    queryPublicationList = [];
    finalCategoryList = categoryList;
    finalPublicationList = publicationList;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _animationController.forward();
    final initScreen = GetStorage().read("initScreen");
    initScreen == 0 || initScreen == null
        ? Future.delayed(Duration(seconds: 2)).then((_) {
            messageController.showMessageOnTheFly(
              title: "Welcome ${authController.name}",
              startingMessageBody:
                  "Get extra 50% discount in your first purchase! Just use ",
              endingMessageBody: "coupon code.",
              coupon: "newUser",
            );
            // messageController.showMessage(
            //     context: context,
            //     startingMessageBody:
            //         "Welcome ${authController.name}! Get extra 50% discount in your first purchase! Just use ",
            //     endingMessageBody: " coupon code.",
            //     coupon: "newUser");
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     action: SnackBarAction(
            //         label: "Copy",
            //         onPressed: () {
            //           final data = ClipboardData(
            //               text: messageController.messageList[0].couponCode);
            //           Clipboard.setData(data);
            //           Fluttertoast.showToast(
            //               msg: "Coupon code is copied in clipboard!");
            //         }),
            //     content: "${messageController.messageList[0].messageBody}"
            //         .text
            //         .make()));
          })
        : Future.delayed(Duration(seconds: 2)).then((_) {
            messageController.showMessageOnTheFly(
                title: "Welcome back ${authController.name}",
                startingMessageBody:
                    "You get 10% extra discount offer! Just use ",
                endingMessageBody: " coupon code",
                coupon: "wbo10");
            // messageController.showMessage(
            //   context: context,
            //   startingMessageBody:
            //       "Welcome back ${authController.name}! You get 10% extra discount offer! Just use",
            //   coupon: "wbo10",
            //   endingMessageBody: "coupon code",
            // );
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     action: SnackBarAction(
            //         label: "Copy",
            //         onPressed: () {
            //           final data = ClipboardData(
            //               text: messageController.messageList[0].couponCode);
            //           Clipboard.setData(data);
            //           Fluttertoast.showToast(
            //               msg: "Coupon code is copied in clipboard!");
            //         }),
            //     content: "${messageController.messageList[0].messageBody}"
            //         .text
            //         .make()));
          });

    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _bookHeight = context.percentHeight * 40;
    final _bookWidth = _bookHeight / 1.55;
    var _swipeUp = false;
    var _swipeDown = false;
    GetStorage().write("initScreen", 1);
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        final maxDuration = Duration(seconds: 2);
        final isWarning =
            lastPressed == null || now.difference(lastPressed!) > maxDuration;

        if (isWarning) {
          lastPressed = DateTime.now();

          Fluttertoast.showToast(
              msg: "Press back again to close the app",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              // backgroundColor: AppColors.deepRed,
              textColor: Colors.white,
              fontSize: 16.0);

          // final snackBar = SnackBar(
          //   content: Text('Double Tap To Close App'),
          //   duration: maxDuration,
          // );

          // ScaffoldMessenger.of(context)
          //   ..removeCurrentSnackBar()
          //   ..showSnackBar(snackBar);

          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onTap: () => searchFocusNode.unfocus(),
        child: Scaffold(
          key: ObjectKey(reDrawHomeScreen),
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          endDrawer: MyDrawer(),
          body: Stack(
            children: [
              SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                        child: Image.asset(
                      "assets/images/background-full.png",
                      fit: BoxFit.cover,
                      height: context.percentHeight * 100 - 100,
                    )),
                    Positioned(
                        top: context.percentHeight * 30,
                        left: context.percentWidth * 10,
                        right: context.percentWidth * 10,
                        child: Opacity(
                            opacity: 0.3,
                            child: Image.asset(
                                "assets/images/bigShelf_logo.png"))),
                    // SizedBox(
                    //   height: 50,
                    //   child: AppBar(
                    //     title: Image.asset(
                    //       "assets/images/logo.png",
                    //       width: 100,
                    //     ),
                    //   ),
                    // ),
                    searchController.text.isEmpty
                        ? Container(
                            padding: EdgeInsets.only(
                              left: context.percentWidth * 10,
                              right: context.percentWidth * 5,
                              top: context.percentHeight * 3.4,
                            ),
                            height: context.percentHeight * 100,
                            width: context.percentWidth * 100,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SearchBar Animated hint text

                                "Search by"
                                    .text
                                    .textStyle(
                                      TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                      ),
                                    )
                                    .make(),
                                6.widthBox,
                                AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      "Name",
                                      textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                      ),
                                      speed: Duration(milliseconds: 100),
                                    ),
                                    TypewriterAnimatedText(
                                      "Author",
                                      textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                      ),
                                      speed: Duration(milliseconds: 100),
                                    ),
                                    TypewriterAnimatedText(
                                      "Category",
                                      textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                      ),
                                      speed: Duration(milliseconds: 100),
                                    ),
                                    TypewriterAnimatedText(
                                      "Publication",
                                      textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                      ),
                                      speed: Duration(milliseconds: 100),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(
                            height: 0,
                            width: 0,
                          ),

                    //Quantity of Books, Publications. Categories

                    !searchFocusNode.hasFocus && query == ""
                        ? Positioned(
                            top: context.percentHeight * 18,
                            left: context.percentWidth * 5,
                            right: context.percentWidth * 5,
                            child: ElasticIn(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.percentWidth * 3,
                                  vertical: context.percentWidth * 3,
                                ),
                                height: context.percentHeight * 10,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  borderRadius: BorderRadius.circular(
                                      context.percentWidth * 3),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        "BOOKS".text.white.make(),
                                        CountUp(
                                          duration:
                                              Duration(milliseconds: 1000),
                                          begin: 0,
                                          end: demoBooks.length.toDouble(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: context.percentWidth * 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        "PUBLICATIONS".text.white.make(),
                                        CountUp(
                                          duration:
                                              Duration(milliseconds: 1000),
                                          begin: 0,
                                          end:
                                              publicationList.length.toDouble(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: context.percentWidth * 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        "CATEGORIES".text.white.make(),
                                        CountUp(
                                          duration:
                                              Duration(milliseconds: 1000),
                                          begin: 0,
                                          end: categoryList.length.toDouble(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: context.percentWidth * 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Positioned(
                            top: context.percentHeight * 18,
                            left: context.percentWidth * 5,
                            right: context.percentWidth * 5,
                            child: Container(
                              height: context.percentWidth * 10,
                              width: double.infinity,
                              child:
                                  //  !searchFocusNode.hasFocus && query == ""
                                  //     ? Container(
                                  //         height: 0,
                                  //         width: 0,
                                  //       )
                                  //     :
                                  searchFocusNode.hasFocus && query == ""
                                      ? ZoomIn(
                                          child: "Recent Views"
                                              .text
                                              .xl3
                                              .bold
                                              .make())
                                      : ZoomIn(
                                          child: "Search Result"
                                              .text
                                              .xl3
                                              .bold
                                              .make()),
                            ),
                          ),
                    !searchFocusNode.hasFocus && query == ""
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: context.percentWidth * 10),
                            child: ElasticIn(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HeightBox(context.percentHeight * 15),
                                  "Search & get your\ndesired book from"
                                      .text
                                      .size(context.percentWidth * 9.5)
                                      .bold
                                      .make(),
                                  "BIG SHELF"
                                      .text
                                      .size(context.percentWidth * 16)
                                      .bold
                                      .make(),
                                ],
                              ),
                            ),
                          )
                        : searchFocusNode.hasFocus &&
                                query == "" &&
                                cartController.recentViews.length == 0
                            ? Center(
                                child: Container(
                                  padding:
                                      EdgeInsets.all(context.percentWidth * 10),
                                  height: context.percentWidth * 100,
                                  width: context.percentWidth * 100,
                                  child: ElasticIn(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Lottie.asset(
                                          "assets/images/recent_view.json",
                                          height: context.percentWidth * 70,
                                          alignment: Alignment.center,
                                        ),
                                        "Recently, you haven't viewed any book!"
                                            .text
                                            .xl
                                            .make(),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : queryBooks.isEmpty && query.length > 0
                                ? Center(
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          context.percentWidth * 10),
                                      height: context.percentWidth * 100,
                                      width: context.percentWidth * 100,
                                      child: ElasticIn(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Lottie.asset(
                                              "assets/images/no_result.json",
                                              height: context.percentWidth * 70,
                                              alignment: Alignment.center,
                                            ),
                                            "Sorry, no results found"
                                                .text
                                                .xl3
                                                .make(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : ValueListenableBuilder<double>(
                                    valueListenable: _notifierScroll,
                                    builder: (context, value, _) {
                                      final recentViewBookList =
                                          cartController.recentViews;
                                      final recentViewBookListInReverse =
                                          List.from(
                                              recentViewBookList.reversed);
                                      return PageView.builder(
                                          key: ValueKey<Object>(reDrawObject),
                                          controller: _controller,
                                          itemCount: searchFocusNode.hasFocus &&
                                                  query == ""
                                              ? cartController
                                                  .recentViews.length
                                              : queryBooks.length,
                                          itemBuilder: (context, index) {
                                            final book = searchFocusNode
                                                        .hasFocus &&
                                                    query == ""
                                                ? recentViewBookListInReverse[
                                                    index]
                                                : queryBooks[index];
                                            final percentage = index - value;
                                            final rotation =
                                                percentage.clamp(0.0, 1.0);
                                            final fixRotation =
                                                pow(rotation, 0.35);
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                left: 20.0,
                                                right: 20,
                                                bottom: 20,
                                                top: context.percentHeight * 8,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          height: _bookHeight,
                                                          width: _bookWidth,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black26,
                                                                  blurRadius:
                                                                      20,
                                                                  offset:
                                                                      Offset(
                                                                          5.0,
                                                                          5.0),
                                                                  spreadRadius:
                                                                      10,
                                                                )
                                                              ]),
                                                        ),
                                                        Transform(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          transform:
                                                              Matrix4.identity()
                                                                ..setEntry(
                                                                    3, 2, 0.002)
                                                                ..rotateY(1.8 *
                                                                    fixRotation)
                                                                ..translate(
                                                                    -rotation *
                                                                        context
                                                                            .percentWidth *
                                                                        150)
                                                                ..scale(1 +
                                                                    rotation),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              showDetailDialog(
                                                                  context,
                                                                  book);
                                                              cartController
                                                                  .addProductsToRecentViews(
                                                                      book);
                                                            },
                                                            onVerticalDragUpdate:
                                                                (DragUpdateDetails
                                                                    drag) {
                                                              if (drag.delta
                                                                      .dy <
                                                                  0) {
                                                                setState(() {
                                                                  _swipeUp =
                                                                      true;
                                                                });
                                                              } else {
                                                                setState(() {
                                                                  _swipeDown =
                                                                      true;
                                                                });
                                                              }
                                                            },
                                                            onVerticalDragEnd:
                                                                (DragEndDetails
                                                                    details) {
                                                              if (_swipeDown) {
                                                                cartController
                                                                    .addProductsToCart(
                                                                        book);
                                                                if (cartController
                                                                        .sumCartQuantity() ==
                                                                    3) {
                                                                  messageController
                                                                      .showMessageOnTheFly(
                                                                    title:
                                                                        "Get free delivery",
                                                                    startingMessageBody:
                                                                        "For purchasing at least 5 books, you will get delivery charge free!",
                                                                    isCopyable:
                                                                        false,
                                                                  );
                                                                  // messageController.showMessage(
                                                                  //     context:
                                                                  //         context,
                                                                  //     startingMessageBody:
                                                                  //         "For purchasing at least 5 books, you will get delivery charge free!",
                                                                  //     endingMessageBody:
                                                                  //         "",
                                                                  //     coupon:
                                                                  //         "",
                                                                  //     snackLebel:
                                                                  //         "");
                                                                }
                                                              } else if (_swipeUp) {
                                                                showDetailDialog(
                                                                    context,
                                                                    book);
                                                              }
                                                            },
                                                            child: Image.asset(
                                                              book.image,
                                                              fit: BoxFit.cover,
                                                              height:
                                                                  _bookHeight,
                                                              width: _bookWidth,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Opacity(
                                                    opacity: 1 - rotation,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        HeightBox(context
                                                                .percentHeight *
                                                            3),
                                                        FadeInRight(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    600),
                                                            child:
                                                                "${book.title}"
                                                                    .text
                                                                    .xl4
                                                                    .bold
                                                                    .make()),
                                                        10.heightBox,
                                                        FadeInRight(
                                                          delay: Duration(
                                                              milliseconds:
                                                                  100),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  600),
                                                          child:
                                                              "by ${book.author}"
                                                                  .text
                                                                  .xl2
                                                                  .color(Colors
                                                                      .grey)
                                                                  .make(),
                                                        ),
                                                        10.heightBox,
                                                        FadeInRight(
                                                          delay: Duration(
                                                              milliseconds:
                                                                  200),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  600),
                                                          child: Row(
                                                            children: [
                                                              "${book.normalPrice}"
                                                                  .text
                                                                  .red500
                                                                  .xl2
                                                                  .textStyle(TextStyle(
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough))
                                                                  .make(),
                                                              10.widthBox,
                                                              "${book.discountedPrice}"
                                                                  .text
                                                                  .xl2
                                                                  .make()
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                  ),

                    //SearchBar

                    Container(
                      padding: EdgeInsets.only(
                        left: context.percentWidth * 5,
                        right: context.percentWidth * 5,
                        top: 0,
                      ),
                      height: context.percentWidth * 20,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              focusNode: searchFocusNode,
                              controller: searchController,
                              onChanged: (String query) {
                                final books = demoBooks.where((book) {
                                  final titleLower = book.title.toLowerCase();
                                  final authorLower = book.author.toLowerCase();
                                  final categoryLower =
                                      book.category.toLowerCase();
                                  final publicationLower =
                                      book.publication.toLowerCase();
                                  final searchLower = query.toLowerCase();

                                  return titleLower.contains(searchLower) ||
                                      authorLower.contains(searchLower) ||
                                      categoryLower.contains(searchLower) ||
                                      publicationLower.contains(searchLower);
                                }).toList();

                                final categories =
                                    categoryList.where((category) {
                                  final categoryLower = category.toLowerCase();
                                  final searchLower = query.toLowerCase();

                                  return categoryLower.contains(searchLower);
                                }).toList();

                                final publications =
                                    publicationList.where((publication) {
                                  final publicationLower =
                                      publication.toLowerCase();
                                  final searchLower = query.toLowerCase();

                                  return publicationLower.contains(searchLower);
                                }).toList();

                                setState(() {
                                  this.query = query;
                                  this.queryBooks = books;
                                  this.queryCategoryList = categories;
                                  this.queryPublicationList = publications;
                                  finalPublicationList = [
                                    ...queryPublicationList,
                                    ...publicationList
                                  ].toSet().toList();
                                  finalCategoryList = [
                                    ...queryCategoryList,
                                    ...categoryList
                                  ].toSet().toList();
                                });
                              },
                              cursorColor: AppColors.green,
                              cursorHeight: 25,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              // autofocus: true,
                              decoration: InputDecoration(
                                suffixIcon: searchController.text.isEmpty
                                    ? ZoomIn(
                                        duration: Duration(milliseconds: 300),
                                        child: Icon(
                                          Icons.search,
                                          color: AppColors.green,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          reDrawObject = Object();
                                          searchController.clear();
                                          query = "";
                                        },
                                        child: ZoomIn(
                                          duration: Duration(milliseconds: 300),
                                          child: Icon(
                                            Icons.close,
                                            color: AppColors.green,
                                          ),
                                        ),
                                      ),
                                filled: true,
                                fillColor: AppColors.green.withOpacity(0.2),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: context.percentWidth * 5,
                                    vertical: context.percentWidth * 3),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.green),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.green),
                                ),
                              ),
                            ),
                          ),
                          WidthBox(context.percentWidth * 3),
                          Builder(
                            builder: (context) => GestureDetector(
                              onTap: () => Scaffold.of(context).openEndDrawer(),
                              child: messageController.clicked
                                  ? CircleAvatar(
                                      backgroundColor: AppColors.green,
                                      child: Icon(Icons.person),
                                      radius: context.percentWidth * 5,
                                      foregroundColor: Colors.white,
                                    )
                                  : CircleAvatar(
                                      backgroundColor: AppColors.green,
                                      child: Badge(
                                          badgeColor: AppColors.deepRed,
                                          elevation: 0,
                                          child: Icon(Icons.person)),
                                      radius: context.percentWidth * 5,
                                      foregroundColor: Colors.white,
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Positioned(
                        top: context.percentHeight * 13.5,
                        left: context.percentWidth * 5,
                        right: context.percentWidth * 5,
                        child: Container(
                          height: context.percentHeight * 3.5,
                          width: context.percentWidth * 80,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  !searchFocusNode.hasFocus && query == ""
                                      ? 0
                                      : finalPublicationList.length,
                              itemBuilder: (context, publicationIndex) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      right: context.percentWidth * 2),
                                  child: GestureDetector(
                                    onTap: () {
                                      searchController.text =
                                          finalPublicationList[
                                              publicationIndex];
                                      searchFocusNode.unfocus();
                                      // query = "";
                                      // queryBooks = [];
                                      setState(() {
                                        reDrawObject = Object();
                                        query = finalPublicationList[
                                            publicationIndex];
                                        queryBooks = demoBooks.where((book) {
                                          final publicationLower =
                                              book.publication.toLowerCase();
                                          final searchLower =
                                              finalPublicationList[
                                                      publicationIndex]
                                                  .toLowerCase();

                                          return publicationLower
                                              .contains(searchLower);
                                        }).toList();
                                        queryPublicationList = [
                                          finalPublicationList[publicationIndex]
                                        ];
                                      });
                                      // queryCategoryList
                                      //     .add(publicationList[index]);
                                    },
                                    child: Badge(
                                      animationDuration: Duration(
                                        milliseconds: 300,
                                      ),
                                      animationType: BadgeAnimationType.scale,
                                      elevation: 0,
                                      shape: BadgeShape.square,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      borderRadius: BorderRadius.circular(
                                          context.percentWidth * 5),
                                      badgeColor: searchFocusNode.hasFocus &&
                                                  query == "" ||
                                              finalCategoryList.contains(query)
                                          ? AppColors.deepRed.withOpacity(0.5)
                                          : _toggleBadgeColorOfPublicationList(
                                              finalPublicationList[
                                                  publicationIndex]),
                                      badgeContent: !searchFocusNode.hasFocus &&
                                              query == ""
                                          ? Container(
                                              height: 0,
                                              width: 0,
                                            )
                                          : "${finalPublicationList[publicationIndex]}"
                                              .text
                                              .makeCentered(),
                                      // : "${queryPublicationList[index]}"
                                      //     .text
                                      //     .makeCentered(),
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                );
                              }),
                        )),

                    Positioned(
                        top: context.percentHeight * 9,
                        left: context.percentWidth * 5,
                        right: context.percentWidth * 5,
                        child: Container(
                          height: context.percentHeight * 3.5,
                          width: context.percentWidth * 80,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  !searchFocusNode.hasFocus && query == ""
                                      ? 0
                                      : finalCategoryList.length,
                              itemBuilder: (context, categoryIndex) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      right: context.percentWidth * 2),
                                  child: GestureDetector(
                                    onTap: () {
                                      searchController.text =
                                          finalCategoryList[categoryIndex];
                                      searchFocusNode.unfocus();
                                      // query = "";
                                      // queryBooks = [];
                                      setState(() {
                                        reDrawObject = Object();
                                        query =
                                            finalCategoryList[categoryIndex];
                                        queryBooks = demoBooks.where((book) {
                                          final categoryLower =
                                              book.category.toLowerCase();
                                          final searchLower =
                                              finalCategoryList[categoryIndex]
                                                  .toLowerCase();

                                          return categoryLower
                                              .contains(searchLower);
                                        }).toList();
                                        queryCategoryList = [
                                          finalCategoryList[categoryIndex]
                                        ];
                                      });
                                      // queryCategoryList
                                      //     .add(publicationList[index]);
                                    },
                                    child: Badge(
                                      animationDuration: Duration(
                                        milliseconds: 300,
                                      ),
                                      animationType: BadgeAnimationType.scale,
                                      elevation: 0,
                                      shape: BadgeShape.square,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      borderRadius: BorderRadius.circular(
                                          context.percentWidth * 5),
                                      badgeColor: searchFocusNode.hasFocus &&
                                                  query == "" ||
                                              finalPublicationList
                                                  .contains(query)
                                          ? AppColors.mediumRed
                                          : _toggleBadgeColorOfCategoryList(
                                              finalCategoryList[categoryIndex]),
                                      badgeContent: !searchFocusNode.hasFocus &&
                                              query == ""
                                          ? Container(
                                              height: 0,
                                              width: 0,
                                            )
                                          : "${finalCategoryList[categoryIndex]}"
                                              .text
                                              .makeCentered(),
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                );
                              }),
                        )),
                  ],
                ),
              ),
              CartBottomSheet()
              // DetailBottomSheet()
            ],
          ),
        ),
      ),
    );
  }
}
