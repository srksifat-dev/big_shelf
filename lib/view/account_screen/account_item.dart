import 'package:flutter/material.dart';

class AccountItem extends StatelessWidget {
  final String sectionTitle;
  final String valueText;
  final Widget icon;
  final double screenWidth;

  const AccountItem({
    required this.icon,
    required this.sectionTitle,
    required this.valueText,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: screenWidth * 0.02,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sectionTitle,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            SizedBox(
              width: screenWidth * 0.01,
            ),
            Container(
              width: screenWidth * 0.5,
              child: Text(
                valueText,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ],
        ),
        // RichText(
        //   text: TextSpan(children: [
        //     TextSpan(
        //         text: sectionTitle,
        //         style: TextStyle(
        //           fontSize: screenWidth * 0.04,
        //           fontWeight: FontWeight.bold,
        //           color: LightColor.black,
        //         )),
        //     TextSpan(
        //       // text: valueText,
        //       style: TextStyle(
        //         color: LightColor.black,
        //         fontSize: screenWidth * 0.04,
        //       ),
        //     ),
        //   ]),
        // ),
      ],
    );
  }
}
