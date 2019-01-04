import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:wan_program/common/Api.dart';
import 'package:wan_program/common/HttpUtils.dart';
import 'package:wan_program/common/Constants.dart';
import 'dart:async';
import 'package:wan_program/item/ArticleItem.dart';
import 'package:banner/banner.dart';
import 'package:wan_program/model/HomeBannerItemModel.dart';
import 'package:wan_program/model/HomeBannerModel.dart';
import 'package:wan_program/common/CommonService.dart';
import 'package:wan_program/Router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomepageState();
  }
}

class HomepageState extends State<HomePage> {
  var page = 0;
  var listTotalSize = 0;
  List listData = new List();

  ScrollController _controller = new ScrollController();
  List<HomeBannerItemModel> _bannerData;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent &&
          listData.length < listTotalSize) {
        getList();
      }
    });
    loadBannerData();
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
            return buildItem(context, i);
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
    String url = Api.BaseUrl + Api.ARTICLE_LIST + "$page/json";
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

  Widget buildItem(BuildContext context, int i) {
    if (i == 0 && null != _bannerData) {
      return _buildBanner(context);
    }else {
      return new ArticleItem(listData[i], false);
    }
  }

  Future<void> _pullToRefresh() async {
    page = 0;
    getList();
    return null;
  }

  //上拉加载更多
  Widget _buildProgressIndicator() {
    var isPerformingRequest;
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  void loadBannerData() async {
    CommonService().getBanner((HomeBannerModel bean) {
      if (bean.data.length > 0) {
        setState(() {
          str = bean;
          _bannerData = bean.data;
          getList();
        });
      }
    });
  }

  var str;

  Widget _buildBanner(BuildContext context) {
    if (null == _bannerData || _bannerData.length <= 0) {
      return Center();
    } else {
      double screenWidth = MediaQueryData.fromWindow(ui.window).size.width;
      return Container(
          height: screenWidth * 4.5 / 9,
          width: screenWidth,
          child: Stack(
            children: <Widget>[
              Card(
                elevation: 4.0,
                shape: Border(),
                margin: EdgeInsets.all(0.0),
                child: BannerView(
                  data: _bannerData,
                  delayTime: 10,
                  onBannerClickListener: (int index, dynamic itemData) {
                    HomeBannerItemModel item = itemData;
                    Router().openWeb(context, item.url, item.title);
                  },
                  buildShowView: (index, data) {
                    return CachedNetworkImage(
                      fit: BoxFit.fill,
                      fadeInDuration: Duration(milliseconds: 0),
                      fadeOutDuration: Duration(milliseconds: 0),
                      imageUrl: (data as HomeBannerItemModel).imagePath,
                    );
                  },
                ),
              ),
//            new Point
            ],
          ));
    }
  }
}
