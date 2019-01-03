import 'package:flutter/material.dart';
import 'package:wan_program/common/Api.dart';
import 'package:wan_program/common/color.dart';
import 'package:wan_program/pages/PictureListPage.dart';
import 'package:flutter/services.dart';

/***
 * 图库首页
 */
class MyPicturePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyPicturePageState();
  }
}

class MyPicturePageState extends State<MyPicturePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Tab> tabs = new List();

  @override
  void initState() {
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
    for (var value in titleList) {
      tabs.add(new Tab(text: value.title));
    }

    _tabController = new TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: titleList.length,
        child: new Scaffold(
            appBar: new TabBar(
              tabs: tabs,
              isScrollable: false,
              controller: _tabController,
              unselectedLabelColor: AppColor.text_color_2,
              labelColor: AppColor.colorPrimary,
              indicatorColor: AppColor.colorPrimary,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: new TextStyle(fontSize: 15.0),
            ),
            body: new TabBarView(
              controller: _tabController,
              children: titleList.map((ImgType itemData) {
                return new PictureListPage(itemData.title, itemData.url);
              }).toList(),
            )));
  }
}

const List<ImgType> titleList = const <ImgType>[
  const ImgType(title: '妹纸', url: Api.GANK_MEIZHI),
  const ImgType(title: '搞笑GIF', url: Api.DUOWAN_BaseUrl + Api.DUOWAN_Gif),
  const ImgType(title: '今日囧图', url: Api.DUOWAN_BaseUrl + Api.DUOWAN_Img),
  const ImgType(title: '视频', url: Api.DUOWAN_BaseUrl + Api.DUOWAN_Vedio),
];

class ImgType {
  const ImgType({this.title, this.url});

  final String title;
  final String url;
}
