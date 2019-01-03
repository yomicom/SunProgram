import 'package:flutter/material.dart';
import 'package:wan_program/common/Api.dart';
import 'package:wan_program/common/HttpUtils.dart';
import 'package:wan_program/common/Constants.dart';
import 'dart:async';
import 'package:wan_program/item/ArticleItem.dart';

class WechatListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WechatListPageState();
  }
  var id;
  WechatListPage(this.id);
}

class WechatListPageState extends State<WechatListPage> {
  var page = 0;
  var listTotalSize = 0;
  List listData = new List();

  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent &&
          listData.length < listTotalSize) {
        getList();
      }
    });
    getList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (listData.length <= 0) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return new RefreshIndicator(
        child: new ListView.builder(
          itemCount: listData.length,
          itemBuilder: (context, i) {
//            if (i == listData.length) {
//              return _buildProgressIndicator();
//            } else {
            return buildItem(i);
//            }
          },
          controller: _controller,
        ),
        onRefresh: _pullToRefresh,
      );
    }
  }

  //获取数据
  void getList() {
    String url = Api.MP_WECHAT_LIST +"${widget.id}/"+ "$page/json";
    HttpUtil.get(url, (data) {
      if (data != null) {
        Map<String, dynamic> map = data;

        var _listData = map['datas'];

        listTotalSize = map["total"];

        setState(() {
          List list1 = new List();
          if (page == 0) {
            listData.clear();
          }
          page++;

          list1.addAll(listData);
          list1.addAll(_listData);
          if (list1.length >= listTotalSize) {
            list1.add(Constants.END_LINE_TAG);
          }
          listData = list1;
        });
      }
    });
  }

  Widget buildItem(int i) {
    return new ArticleItem(listData[i],true);
  }

  Future<void> _pullToRefresh() async {
    page = 0;
    getList();
    return null;
  }
}
