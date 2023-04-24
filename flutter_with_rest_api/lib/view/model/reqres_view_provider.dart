import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_with_rest_api/model/model.dart';
import 'package:flutter_with_rest_api/service/reqres_servis.dart';

class ReqresViewProvider extends ChangeNotifier {
  ReqresViewProvider(this.reqresService) {
    _fetch();
  }

  final IReqresService reqresService;

  List<Data> users = [];
  bool isLoading = false;

  void _changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> _fetch() async {
    _changeLoading();
    users = (await reqresService.fetchUsersItem())?.data ?? [];
    _changeLoading();
  }

  Future<void> refresh() async {
    _changeLoading();
    users = (await reqresService.fetchUsersItem())?.data ?? [];
    _changeLoading();
  }




}
