import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_with_rest_api/model/model.dart';

abstract class IReqresService {
  IReqresService(this.dio);

  final Dio dio;
  Future<UsersModel?> fetchUsersItem();
}

class ReqresService extends IReqresService {
  ReqresService(Dio dio) : super(dio);
  final String _path = '/users?page=2';
  @override
  Future<UsersModel?> fetchUsersItem() async {
    final response = await dio.get(_path);
    if (response.statusCode == HttpStatus.ok) {
      final jsonBody = response.data;
      if (jsonBody is Map<String, dynamic>) {
        return UsersModel.fromJson(jsonBody);
      }
    }
    return null;
  }
}
