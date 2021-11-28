import 'package:animate_do/animate_do.dart';
import 'package:big_shelf/controller/auth_controller.dart';
import 'package:big_shelf/view/account_screen/account_screen.dart';
import 'package:big_shelf/view/global_widget/custom_text_field.dart';
import 'package:big_shelf/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:velocity_x/velocity_x.dart';

class EditAccountDialogContent extends StatefulWidget {
  const EditAccountDialogContent({Key? key}) : super(key: key);

  @override
  _EditAccountDialogContentState createState() =>
      _EditAccountDialogContentState();
}

class _EditAccountDialogContentState extends State<EditAccountDialogContent> {
  final authController = Get.find<AuthController>();
  final TextEditingController name = TextEditingController();
  final TextEditingController contactNumber = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final nameFocusNode = FocusNode();
  final contactNumberFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  final passwordFocusNode = FocusNode();

  ButtonState _buttonState = ButtonState.idle;

  bool _obscure = true;

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void initState() {
    name.text = "${authController.name}";
    contactNumber.text = "${authController.contactNumber}";
    email.text = "${authController.email}";
    // if (authController.country != "") country.text = authController.country;
    // if (authController.state != "") state.text = authController.state;
    // if (authController.city != "") city.text = authController.city;
    // if (authController.detailAddress != "")
    //   detailsAddress.text = authController.detailAddress;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: context.percentHeight * 27,
          child: ElasticIn(
            duration: Duration(milliseconds: 1000),
            child: Container(
              padding: EdgeInsets.only(
                left: context.percentWidth * 5,
                right: context.percentWidth * 5,
                top: context.percentWidth * 6,
              ),
              height: context.percentHeight * 45,
              width: context.percentWidth * 90,
              decoration: BoxDecoration(
                color: AppColors.lightRed,
                borderRadius: BorderRadius.circular(context.percentWidth * 5),
              ),
              child: Column(
                children: [
                  "Edit Account".text.xl2.bold.makeCentered(),
                  HeightBox(context.percentHeight * 2),
                  customTextField(
                    context: context,
                    controller: name,
                    focusNode: nameFocusNode,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, nameFocusNode, contactNumberFocusNode);
                    },
                    hintText: "Name",
                    fillColor: AppColors.green.withOpacity(0.2),
                    borderColor: AppColors.green,
                  ),
                  HeightBox(context.percentHeight * 1),
                  customTextField(
                    context: context,
                    controller: contactNumber,
                    focusNode: contactNumberFocusNode,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, contactNumberFocusNode, emailFocusNode);
                    },
                    hintText: "Contact No.",
                    fillColor: AppColors.green.withOpacity(0.2),
                    borderColor: AppColors.green,
                    textInputType: TextInputType.phone,
                  ),
                  HeightBox(context.percentHeight * 1),
                  customTextField(
                    context: context,
                    controller: email,
                    focusNode: emailFocusNode,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, emailFocusNode, passwordFocusNode);
                    },
                    hintText: "Email Address",
                    fillColor: AppColors.green.withOpacity(0.2),
                    borderColor: AppColors.green,
                    textCapitalization: TextCapitalization.none,
                    textInputType: TextInputType.emailAddress,
                  ),
                  HeightBox(context.percentHeight * 1),
                  customTextField(
                    context: context,
                    controller: password,
                    focusNode: passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (term) {
                      passwordFocusNode.unfocus();
                      setState(() {
                        _buttonState = ButtonState.loading;
                      });
                      contactNumber.text.isNotEmpty &&
                              password.text.isNotEmpty &&
                              name.text.isNotEmpty &&
                              email.text.isNotEmpty &&
                              password.text == authController.password
                          ? Future.delayed(Duration(seconds: 2))
                              .then((_) => setState(() {
                                    _buttonState = ButtonState.success;
                                    authController.name = name.text;
                                    authController.contactNumber =
                                        contactNumber.text;
                                    authController.email = email.text;
                                  }))
                              .then((_) =>
                                  Future.delayed(Duration(milliseconds: 800)))
                              .then((_) => Get.off(() => AccountScreen()))
                          : Future.delayed(Duration(seconds: 2))
                              .then((_) => setState(() {
                                    _buttonState = ButtonState.fail;
                                  }))
                              .then((_) =>
                                  Future.delayed(Duration(milliseconds: 500)))
                              .then((_) => _buttonState = ButtonState.idle);
                    },
                    hintText: "Password",
                    fillColor: AppColors.green.withOpacity(0.2),
                    borderColor: AppColors.green,
                    obscureText: _obscure,
                    suffixIcon: _obscure
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscure = false;
                              });
                            },
                            child: ZoomIn(
                              duration: Duration(milliseconds: 300),
                              child: Icon(
                                Icons.visibility_off,
                                color: AppColors.green,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscure = true;
                              });
                            },
                            child: ZoomIn(
                              duration: Duration(milliseconds: 300),
                              child: Icon(
                                Icons.visibility,
                                color: AppColors.green,
                              ),
                            ),
                          ),
                  ),
                  HeightBox(context.percentHeight * 2),
                  ProgressButton.icon(
                      iconedButtons: {
                        ButtonState.idle: IconedButton(
                            icon:
                                Icon(Icons.arrow_forward, color: Colors.white),
                            color: AppColors.green),
                        ButtonState.loading:
                            IconedButton(color: AppColors.deepRed),
                        ButtonState.fail: IconedButton(
                            text: "Failed",
                            icon: Icon(Icons.cancel, color: Colors.white),
                            color: AppColors.deepRed),
                        ButtonState.success: IconedButton(
                            text: "Success",
                            icon: Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                            color: AppColors.green)
                      },
                      onPressed: () {
                        nameFocusNode.unfocus();
                        contactNumberFocusNode.unfocus();
                        emailFocusNode.unfocus();
                        passwordFocusNode.unfocus();
                        setState(() {
                          _buttonState = ButtonState.loading;
                        });
                        contactNumber.text.isNotEmpty &&
                                password.text.isNotEmpty &&
                                name.text.isNotEmpty &&
                                email.text.isNotEmpty &&
                                password.text == authController.password
                            ? Future.delayed(Duration(seconds: 2))
                                .then((_) => setState(() {
                                      _buttonState = ButtonState.success;
                                      authController.name = name.text;
                                      authController.contactNumber =
                                          contactNumber.text;
                                      authController.email = email.text;
                                    }))
                                .then((_) =>
                                    Future.delayed(Duration(milliseconds: 800)))
                                .then((_) {
                                Get.back();
                                Get.off(() => AccountScreen());
                              })
                            : Future.delayed(Duration(seconds: 2))
                                .then((_) => setState(() {
                                      _buttonState = ButtonState.fail;
                                    }))
                                .then((_) =>
                                    Future.delayed(Duration(milliseconds: 500)))
                                .then((_) => _buttonState = ButtonState.idle);
                      },
                      state: _buttonState),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: context.percentHeight * 20,
          child: ElasticIn(
            duration: Duration(milliseconds: 1000),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.5),
                radius: context.percentWidth * 6,
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
