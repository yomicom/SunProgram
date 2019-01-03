import 'dart:async';

import 'package:dio/dio.dart';
import 'Api.dart';
import 'package:wan_program/common/Api.dart';

import 'package:wan_program/model/AuthorResultModel.dart';

class CommonService {
  void getWechatNames(Function callback) {
    Dio()
        .get(Api.BaseUrl + Api.AUTHOR_LIST, options: _getOptions())
        .then((response) {
      callback(AuthorResultModel.fromJson(response.data));
    });
  }

  Options _getOptions() {
    return Options();
  }
}
