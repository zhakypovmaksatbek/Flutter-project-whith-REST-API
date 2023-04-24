import 'package:flutter/material.dart';
import 'package:flutter_with_rest_api/product/service/constants/color_constants.dart';
import 'package:flutter_with_rest_api/product/service/constants/custom_text_style.dart';
import 'package:flutter_with_rest_api/product/service/project_dio.dart';
import 'package:flutter_with_rest_api/view/model/reqres_view_provider.dart';
import 'package:flutter_with_rest_api/view/reqres_view.dart';
import 'package:provider/provider.dart';

import 'service/reqres_servis.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget with ProjectDioMixin {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReqresViewProvider(ReqresService(service)),
      builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              cardColor: Colors.transparent,
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.transparent,
              appBarTheme: const AppBarTheme(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  titleTextStyle: CustomTextStyles.heading1,
                  centerTitle: true,
                  iconTheme: IconThemeData(color: ColorConstants.white),
                  actionsIconTheme:
                      IconThemeData(color: ColorConstants.white))),
          title: 'Material App',
          home: const ReqResView()),
    );
  }
}
