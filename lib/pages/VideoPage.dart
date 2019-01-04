import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:wan_program/common/Api.dart';
import 'dart:convert';
import 'package:wan_program/model/PicInfo.dart';
import 'package:wan_program/model/PictureGalleryModel.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

/**
 * 多玩视频详情页
 */
class VideoPage extends StatefulWidget {
  var id;

  VideoPage(this.id);

  @override
  State<StatefulWidget> createState() {
    return VideoPageState();
  }
}

class VideoPageState extends State<VideoPage> {
  var curIndex = 0;
  List<PicInfo> imgs;

  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    getImageList();
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (imgs != null) {
      PicInfo data = imgs[curIndex];
      return new Scaffold(
        key: _globalKey,
        body: new Stack(
          children: <Widget>[
            new Center(child: new CircularProgressIndicator()),
            new Center(
              child: new GestureDetector(
                  child: new Container(
                    child: new Chewie(
                      new VideoPlayerController.network(
                          "http:${data.video_url}"),
                      aspectRatio: 3 / 2,
                      autoPlay: true,
                      looping: true,
                    ),
                    color: Colors.black,
                    alignment: Alignment.center,
                  ),
                  onTapDown: (detail) {
                    var middleWidth = MediaQuery.of(context).size.width / 2;
                    print("AAA${detail.globalPosition.dx}");
                    if (detail.globalPosition.dx < middleWidth) {
                      _reduceCounter();
                    } else {
                      _incrementCounter();
                    }
                  }),
            ),
            new Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 15.0),
              child: new Text(
                data.add_intro,
                style: TextStyle(fontSize: 16.0, color: Color(0xDDD0D0D0)),
              ), //
            ),
          ],
        ),
//
      );
    } else {
      return new Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: new CircularProgressIndicator(),
      );
    }
  }

  void _incrementCounter() {
    setState(() {
      if (curIndex < imgs.length - 1)
        curIndex++;
      else
        _globalKey.currentState
            .showSnackBar(SnackBar(content: Text("图集已经浏览完毕")));
    });
  }

  void _reduceCounter() {
    setState(() {
      if (curIndex > 0) curIndex--;
    });
  }

  //获取图片数据
  Future<Null> getImageList() async {
    Dio dio = new Dio();
    String url = Api.DUOWAN_BaseUrl + Api.DUOWAN_Gallery + widget.id;
    Response response = await dio.get(url);
    Map<String, dynamic> jsonData = json.decode(response.data.toString());
    PictureGalleryModel model = PictureGalleryModel.fromJson(jsonData);
    setState(() {
      imgs = model.picInfo;
    });
  }
}
