import 'package:flutter/material.dart';

import '../../product/service/constants/color_constants.dart';
import '../../product/service/constants/custom_text_style.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          // height: 60,
          // width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color.fromARGB(255, 212, 214, 213)),
            gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: [
                  ColorConstants.skyMagenta,
                  ColorConstants.perBlue,
                  ColorConstants.blue,
                ]),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Center(
              child: Text(
                "BACK",
                style: CustomTextStyles.heading1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
