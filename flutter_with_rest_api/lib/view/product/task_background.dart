// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../product/service/constants/color_constants.dart';

class BackgrounColorContainer extends StatelessWidget {
  const BackgrounColorContainer({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              ColorConstants.skyMagenta,
              ColorConstants.perBlue,
              ColorConstants.blue,
            ]),
      ),
      child: child,
    );
  }
}
