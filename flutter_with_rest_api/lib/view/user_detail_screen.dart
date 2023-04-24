import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_with_rest_api/product/service/constants/string_constants.dart';
import 'package:flutter_with_rest_api/product/service/project_dio.dart';
import 'package:flutter_with_rest_api/service/reqres_servis.dart';
import 'package:flutter_with_rest_api/view/model/reqres_view_provider.dart';
import 'package:flutter_with_rest_api/view/product/back_button.dart';
import 'package:flutter_with_rest_api/view/product/custom_container.dart';
import 'package:flutter_with_rest_api/view/product/task_background.dart';
import 'package:provider/provider.dart';

import '../model/model.dart';

class UserDetailScreen extends StatelessWidget with ProjectDioMixin {
  final Data user;

  UserDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reqresWatchProvider = context.watch<ReqresViewProvider>();

    return ChangeNotifierProvider(
      create: (context) => ReqresViewProvider(ReqresService(service)),
      builder: (context, child) {
        return BackgrounColorContainer(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                '${user.firstName} ${user.lastName}',
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: CachedNetworkImage(
                          height: 200,
                          fit: BoxFit.cover,
                          imageUrl: user.avatar ?? '',
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          cacheManager: DefaultCacheManager(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomContainerWidget(
                      icon: StringConstants.idIcon,
                      description: StringConstants.idNum,
                      name: user.id.toString(),
                    ),
                    CustomContainerWidget(
                      icon: StringConstants.nameIcon,
                      description: StringConstants.fullName,
                      name: '${user.firstName} ${user.lastName}',
                    ),
                    CustomContainerWidget(
                      icon: StringConstants.emailIcon,
                      description: StringConstants.email,
                      name: user.email ?? "",
                    ),
                    const MyBackButton(),
                   
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
