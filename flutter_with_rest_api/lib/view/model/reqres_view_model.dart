import 'package:flutter/material.dart';
import 'package:flutter_with_rest_api/model/model.dart';
import 'package:flutter_with_rest_api/product/service/project_dio.dart';
import 'package:flutter_with_rest_api/service/reqres_servis.dart';
import 'package:flutter_with_rest_api/view/reqres_view.dart';

abstract class ReqResViewModel extends LoadingStateful<ReqResView>
    with ProjectDioMixin {
  late final IReqresService reqresService;

  List<Data> users = [];

  @override
  void initState() {
    super.initState();
    reqresService = ReqresService(service);
    _fetch();
  }

  Future<void> _fetch() async {
    changeLoading();
    users = (await reqresService.fetchUsersItem())?.data ?? [];
    changeLoading();
  }
}

abstract class LoadingStateful<T extends StatefulWidget> extends State<T> {
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
