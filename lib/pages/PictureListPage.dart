import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:wan_program/common/styles.dart';
import 'package:wan_program/model/ganhuo.dart';
import 'package:wan_program/pages/ImagePreViewPage.dart';
import 'package:wan_program/pages/ImageDetailsPage.dart';
import 'package:wan_program/pages/VideoPage.dart';
import 'package:flutter/services.dart';

/**
 * 图库列表页
 */
class PictureListPage extends StatefulWidget {
  String url;
  var title;

  @override
  State<StatefulWidget> createState() {
    return new PictureListpageState();
  }

  PictureListPage(this.title, this.url);
}

class PictureListpageState extends State<PictureListPage> {
  var page = 0;
  int pageSize = 30;
  List listData = new List();

  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
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
        child: new StaggeredGridView.countBuilder(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 4.0),
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2
                  : 4,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          itemCount: listData.length,
          itemBuilder: (context, i) {
            return buildItem(i);
          },
          controller: _controller,
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
        ),
        onRefresh: _pullToRefresh,
      );
    }
  }

  //获取数据
  Future<Null> getList() async {
    Dio dio = new Dio();
    if ("妹纸" == widget.title) {
      page++;
      Response response = await dio.get("${widget.url}/$pageSize/$page");

      GanHuos ganHuos = GanHuos.fromJson(response.data);
      setState(() {
        listData.addAll(ganHuos.results);
      });
    } else {
      var offset = page * pageSize;
      String url =
          widget.url + "offset=$offset&order=created&math=0.31623082021693727";
      Response response = await dio.get(url + page.toString());
      var data = response.data.toString();
      Map<String, dynamic> map = json.decode(data);

      var html = map['html'];
      page++;

      setState(() {
        List list1 = dealHtml(html);
        if (page == 0) {
          listData.clear();
        }
//        list1.addAll(listData);
        listData.addAll(list1);
      });
    }
  }

  Widget buildItem(int i) {
    if ("妹纸" == widget.title) {
      GanHuo ganHuo = listData[i];
      return new GestureDetector(
        child: new Hero(
          tag: ganHuo.url,
          child: CachedNetworkImage(imageUrl: ganHuo.url),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new ImagePreViewPage(url: ganHuo.url),
              ));
        },
      );
    } else {
      var itemData = listData[i];
      return new Card(
        elevation: 3.0,
        child: new InkWell(
          child: new Column(
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  new Image(image: NetworkImage(itemData['url'])),
                  widget.title == "视频"
                      ? new Icon(
                          Icons.video_call,
                          size: 30.0,
                          color: Colors.white,
                        )
                      : new Container(),
                ],
                alignment: Alignment.center,
              ),
              new Padding(
                padding: EdgeInsets.only(
                    left: 10.0, top: 8.0, right: 10.0, bottom: 10.0),
                child: new Text(
                  itemData['title'],
                  style: AppStyles.title_style_2,
                ),
              )
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => widget.title == "视频"
                      ? VideoPage(itemData['id'])
                      : ImageDetialsPage(itemData['id'])),
            );
          },
        ),
      );
    }
  }

  Future<void> _pullToRefresh() async {
    page = 0;
    getList();
    return null;
  }

  //处理html代码
  List dealHtml(String html) {
    List list = new List();
    List<String> gallery =
        html.split("<em><a href=\"http://tu.duowan.com/gallery/");
    List<String> split = html.split("<img src=\"");
    for (int i = 1; i < split.length; i++) {
      var itemStr = split[i];
      var galleryStr = gallery[i];
      var url = itemStr.split("\"")[0];
      var title = itemStr
          .substring(itemStr.indexOf("_blank\">"))
          .replaceAll("_blank\">", "");
      title = title.substring(0, title.indexOf("</a>"));

      Map map = new Map();
      map["title"] = title;
      map["url"] = url;
      map["id"] = galleryStr.substring(0, galleryStr.indexOf(".html"));

      if (widget.title == "视频") {
        if (title.contains("爆笑视频")) {
          list.add(map);
        }
      } else {
        list.add(map);
      }
    }
    return list;
  }
}
