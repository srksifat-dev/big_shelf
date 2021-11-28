import 'package:animate_do/animate_do.dart';
import 'package:big_shelf/controller/auth_controller.dart';
import 'package:big_shelf/view/global_widget/custom_text_field.dart';
import 'package:big_shelf/view/home_screen/home_screen.dart';
import 'package:big_shelf/view/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:progress_state_button/progress_button.dart';

class SignInForm extends StatefulWidget {
  SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final authController = Get.find<AuthController>();
  final contactNumberText = TextEditingController();
  final passwordText = TextEditingController();

  final contactNumberFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  ButtonState _buttonState = ButtonState.idle;

  bool _obscure = true;

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 12),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            customTextField(
              context: context,
              focusNode: contactNumberFocusNode,
              controller: contactNumberText,
              onFieldSubmitted: (term) {
                _fieldFocusChange(
                    context, contactNumberFocusNode, passwordFocusNode);
              },
              hintText: "Contact Number",
              fillColor: AppColors.deepRed.withOpacity(0.2),
              borderColor: AppColors.deepRed,
              textInputType: TextInputType.phone,
            ),
            // TextFormField(
            //   focusNode: emailFocusNode,
            //   controller: emailText,
            //   keyboardType: TextInputType.emailAddress,
            //   cursorColor: AppColors.deepRed,
            //   decoration: InputDecoration(
            //     hintText: "Email",
            //     filled: true,
            //     fillColor: AppColors.deepRed.withOpacity(0.2),
            //     contentPadding: EdgeInsets.symmetric(
            //         horizontal: context.percentWidth * 5,
            //         vertical: context.percentWidth * 3),
            //     enabledBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: AppColors.deepRed),
            //     ),
            //     focusedBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: AppColors.deepRed),
            //     ),
            //   ),
            // ),
            HeightBox(context.percentHeight * 2),
            customTextField(
              context: context,
              focusNode: passwordFocusNode,
              controller: passwordText,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (term){
                passwordFocusNode.unfocus();
                  setState(() {
                    _buttonState = ButtonState.loading;
                  });
                  contactNumberText.text.isNotEmpty &&
                          passwordText.text.isNotEmpty
                      ? Future.delayed(Duration(seconds: 2))
                          .then((_) => setState(() {
                                _buttonState = ButtonState.success;
                                authController.contactNumber =
                                    contactNumberText.text;
                                authController.password = passwordText.text;
                              }))
                          .then((_) =>
                              Future.delayed(Duration(milliseconds: 800)))
                          .then((_) => Get.off(() => HomeScreen()))
                      : Future.delayed(Duration(seconds: 2))
                          .then((_) => setState(() {
                                _buttonState = ButtonState.fail;
                              }))
                          .then((_) =>
                              Future.delayed(Duration(milliseconds: 500)))
                          .then((_) => _buttonState = ButtonState.idle);
              },
              hintText: "Password",
              fillColor: AppColors.deepRed.withOpacity(0.2),
              borderColor: AppColors.deepRed,
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
                          color: AppColors.deepRed,
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
                          color: AppColors.deepRed,
                        ),
                      ),
                    ),
            ),
            HeightBox(context.percentHeight * 2),
            TextButton(
                onPressed: () {
                  contactNumberFocusNode.unfocus();
                  passwordFocusNode.unfocus();
                },
                child: "Forgot password?"
                    .text
                    .color(AppColors.deepRed)
                    .makeCentered()),
            HeightBox(context.percentHeight * 2),
            ProgressButton.icon(
                iconedButtons: {
                  ButtonState.idle: IconedButton(
                      icon: Icon(Icons.arrow_forward, color: Colors.white),
                      color: AppColors.deepRed),
                  ButtonState.loading: IconedButton(color: AppColors.deepRed),
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
                  contactNumberFocusNode.unfocus();
                  passwordFocusNode.unfocus();
                  setState(() {
                    _buttonState = ButtonState.loading;
                  });
                  contactNumberText.text.isNotEmpty &&
                          passwordText.text.isNotEmpty
                      ? Future.delayed(Duration(seconds: 2))
                          .then((_) => setState(() {
                                _buttonState = ButtonState.success;
                                authController.contactNumber =
                                    contactNumberText.text;
                                authController.password = passwordText.text;
                              }))
                          .then((_) =>
                              Future.delayed(Duration(milliseconds: 800)))
                          .then((_) => Get.off(() => HomeScreen()))
                      : Future.delayed(Duration(seconds: 2))
                          .then((_) => setState(() {
                                _buttonState = ButtonState.fail;
                              }))
                          .then((_) =>
                              Future.delayed(Duration(milliseconds: 500)))
                          .then((_) => _buttonState = ButtonState.idle);
                },
                state: _buttonState),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
