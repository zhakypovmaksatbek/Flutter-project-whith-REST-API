// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_with_rest_api/product/service/constants/color_constants.dart';
import 'package:flutter_with_rest_api/product/service/constants/custom_text_style.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../product/service/project_dio.dart';
import '../../service/reqres_servis.dart';
import '../model/reqres_view_provider.dart';

class CustomContainerWidget extends StatelessWidget with ProjectDioMixin {
  CustomContainerWidget({
    Key? key,
    //required this.data,
    required this.icon,
    required this.name,
    required this.description,
  }) : super(key: key);
  //final Data data;
  final String icon;
  final String name;
  final String description;
  //bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReqresViewProvider(ReqresService(service)),
      builder: (context, child) {
        final reqresWatchProvider = context.watch<ReqresViewProvider>();

        return Card(
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                SizedBox(
                    height: 90,
                    width: 90,
                    child: !reqresWatchProvider.isLoading
                        ? LottieBuilder.network(icon)
                        : const Center(
                            child: CircularProgressIndicator(
                            color: ColorConstants.perBlue,
                          ))),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description,
                        style: CustomTextStyles.description
                            .copyWith(color: ColorConstants.skyMagenta),
                      ),
                      Text.rich(
                          TextSpan(
                            text: name,
                            style: context.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.perBlue),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.visible),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
