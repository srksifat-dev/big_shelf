import 'package:big_shelf/view/account_screen/address_dialog_content.dart';
import 'package:flutter/material.dart';

Future showAddressDialog(BuildContext context) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext context, Animation animation,
        Animation secondaryAnimation) {
      return Material(
        color: Colors.transparent,
        child: AddressDialogContent(),
      );
    },
  );
}
