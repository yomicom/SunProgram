import 'package:flutter/material.dart';
import 'package:wan_program/common/Api.dart';
import 'package:wan_program/common/color.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:wan_program/model/AuthorModel.dart';
import 'package:wan_program/model/AuthorResultModel.dart';
import 'package:wan_program/pages/WechatListPage.dart';
import 'package:wan_program/common/CommonService.dart';

class WeChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WechatPageState();
  }
}

class WechatPageState extends State<WeChatPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Tab> tabs = new List();
  List<AuthorModel> authorList = new List();

  @override
  void initState() {
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
    getTabList();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new CircularProgressIndicator(),
        tabs.length > 0 ? new DefaultTabController(
                length: authorList.length,
                child: new Scaffold(
                    appBar: new TabBar(
                      tabs: tabs,
                      isScrollable: true,
                      controller: _tabController,
                      unselectedLabelColor: AppColor.text_color_2,
                      labelColor: AppColor.colorPrimary,
                      indicatorColor: AppColor.colorPrimary,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: new TextStyle(fontSize: 15.0),
                    ),
                    body: new TabBarView(
                      controller: _tabController,
                      children: authorList.map((itemData) {
                        return new WechatListPage(itemData.id);
                      }).toList(),
                    )))
            : new Text(""),
//        new Text(str.toString()),
      ],
    );
  }

  List<String> str = new List();

  void getTabList() async {
    CommonService().getWechatNames((AuthorResultModel model) {
      if (model.data.length > 0) {
        setState(() {
          authorList = model.data;
          for (AuthorModel value in authorList) {
//            str = value.name + "AA";
            str.add(value.name);
            tabs.add(new Tab(text: value.name));
          }

          _tabController = TabController(length: tabs.length, vsync: this);
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
