import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_with_rest_api/product/service/constants/custom_text_style.dart';
import 'package:flutter_with_rest_api/product/service/constants/string_constants.dart';
import 'package:flutter_with_rest_api/product/service/project_dio.dart';
import 'package:flutter_with_rest_api/service/reqres_servis.dart';

import 'package:flutter_with_rest_api/view/model/reqres_view_provider.dart';
import 'package:flutter_with_rest_api/view/product/task_background.dart';
import 'package:flutter_with_rest_api/view/user_detail_screen.dart';
import 'package:provider/provider.dart';

import '../model/model.dart';
import '../product/service/constants/color_constants.dart';

class ReqResView extends StatefulWidget {
  const ReqResView({super.key});

  @override
  State<ReqResView> createState() => _ReqResViewState();
}

class _ReqResViewState extends State<ReqResView> with ProjectDioMixin {
  @override
  Widget build(BuildContext context) {
    final reqresWatchProvider = context.watch<ReqresViewProvider>();
    final reqresReadProvider = context.read<ReqresViewProvider>();

    return ChangeNotifierProvider<ReqresViewProvider>(
        create: (context) => ReqresViewProvider(ReqresService(service)),
        builder: (context, child) {
          return BackgrounColorContainer(
            child: Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                        onPressed: () {
                          _addNewUser(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              final firstNameController =
                                  TextEditingController();
                              final lastNameController =
                                  TextEditingController();
                              final emailController = TextEditingController();
                              final avatarController = TextEditingController();
                              return AlertDialog(
                                title: const Text("Add User"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: firstNameController,
                                      decoration: const InputDecoration(
                                        labelText: 'First Name',
                                      ),
                                    ),
                                    TextField(
                                      controller: lastNameController,
                                      decoration: const InputDecoration(
                                        labelText: 'Last Name',
                                      ),
                                    ),
                                    TextField(
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                        labelText: 'Email',
                                      ),
                                    ),
                                    TextField(
                                      controller: avatarController,
                                      decoration: const InputDecoration(
                                        labelText: 'Avatar URL',
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final firstName =
                                          firstNameController.text;
                                      final lastName = lastNameController.text;
                                      final email = emailController.text;
                                      final avatar = avatarController.text;
                                      final user = Data(
                                        firstName: firstName,
                                        lastName: lastName,
                                        email: email,
                                        avatar: avatar,
                                      );
                                      // await context.read<ReqresViewProvider>().addUser(user);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Add"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.add))
                  ],
                  title: reqresWatchProvider.isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(StringConstants.appName),
                ),
                body: RefreshIndicator(
                  backgroundColor: Colors.white,
                  color: ColorConstants.skyMagenta,
                  onRefresh: () => reqresReadProvider.refresh(),
                  child: ListView.builder(
                      itemCount: reqresWatchProvider.users.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                                color:
                                    const Color.fromARGB(113, 224, 170, 255)),
                            onDismissed: (direction) {
                              if (index <
                                  context
                                      .read<ReqresViewProvider>()
                                      .users
                                      .length) {
                                context
                                    .read<ReqresViewProvider>()
                                    .users
                                    .removeAt(index);
                              }
                            },
                            child: Consumer<ReqresViewProvider>(
                              builder: (context, value, child) {
                                return _usersListTile(reqresWatchProvider,
                                    index, context, reqresReadProvider);
                              },
                            ));
                      }),
                )),
          );
        });
  }

  Future<dynamic> _addNewUser(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final firstNameController = TextEditingController();
        final lastNameController = TextEditingController();
        final emailController = TextEditingController();
        final avatarController = TextEditingController();
        return AlertDialog(
          title: const Text("Add User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: avatarController,
                decoration: const InputDecoration(
                  labelText: 'Avatar URL',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  ListTile _usersListTile(ReqresViewProvider reqresWatchProvider, int index,
      BuildContext context, ReqresViewProvider reqresReadProvider) {
    return ListTile(
      leading: _cachedImage(reqresWatchProvider, index),
      title: Center(
        child: Text(
          reqresWatchProvider.users[index].lastName ?? '',
          style: CustomTextStyles.heading1,
        ),
      ),
      subtitle: Center(
        child: Text(
          textAlign: TextAlign.start,
          reqresWatchProvider.users[index].email ?? '',
          style: CustomTextStyles.description,
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  UserDetailScreen(user: reqresReadProvider.users[index]),
            ));
      },
    );
  }

  CachedNetworkImage _cachedImage(
      ReqresViewProvider reqresWatchProvider, int index) {
    return CachedNetworkImage(
      imageUrl: reqresWatchProvider.users[index].avatar ?? '',
      placeholder: (context, url) => const CircularProgressIndicator(
        color: Colors.amber,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      cacheManager: DefaultCacheManager(),
    );
  }
}
