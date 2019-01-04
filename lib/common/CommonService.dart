import 'dart:async';

import 'package:dio/dio.dart';
import 'Api.dart';
import 'package:wan_program/common/Api.dart';

import 'package:wan_program/model/AuthorResultModel.dart';
import 'package:wan_program/model/HomeBannerModel.dart';

class CommonService {
  void getBanner(Function callback) async{
    Dio().get(Api.HOME_BANNER, options: _getOptions())
        .then((response) {
      callback(HomeBannerModel.fromJson(response.data));
    });
  }
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
