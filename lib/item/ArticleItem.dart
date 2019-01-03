import 'package:flutter/material.dart';
import 'package:wan_program/common/color.dart';
import 'package:wan_program/common/styles.dart';
import 'package:wan_program/widgets/StrokeWidget.dart';
import 'package:wan_program/pages/ArticleDetailPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ArticleItem extends StatefulWidget {
  var itemData;
  bool haveImg;

  @override
  State<StatefulWidget> createState() {
    return ArticleItemState();
  }

  ArticleItem(var itemData, bool haveImg) {
    this.itemData = itemData;
    this.haveImg = haveImg;
  }
}

class ArticleItemState extends State<ArticleItem> {
//  TextStyle titleTextstyle = new TextStyle(color: );
  Map<String, dynamic> articleData;

  @override
  void initState() {
    getCover();
    super.initState();
  }

  void getCover() async {
    http.Response res = await http.get("${widget.itemData['link']}?f=json");
    setState(() {
      var body = res.body;
      if (body.startsWith("{")) {
        articleData = json.decode(body);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          border: new Border(
              bottom:
                  new BorderSide(color: AppColor.color_divide, width: 0.5))),
      child: new InkWell(
        child: new Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Container(
                  height: 65.0,
                  padding: EdgeInsets.fromLTRB(
                      15.0, 15.0, widget.haveImg ? 78.0 : 15.0, 10.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Text(
                          widget.itemData['title'],
                          style: AppStyles.title_style,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.haveImg
                    ? new Container()
                    : new Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 10.0),
                        child: new Row(
                          children: <Widget>[
                            new StrokeWidget(
                              childWidget: new Text(
                                widget.itemData['superChapterName'],
                                style: AppStyles.primary_text_style3,
                                textAlign: TextAlign.center,
                              ),
                              color: AppColor.colorPrimary,
                              strokeWidth: 0.5,
                              strokeRadius: 3.0,
                              edgeInsets: EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 2.0),
                            ),
                            new Divider(
                              indent: 12.0,
                            ),
                            new StrokeWidget(
                              childWidget: new Text(
                                widget.itemData['chapterName'],
                                style: AppStyles.primary_text_style3,
                                textAlign: TextAlign.center,
                              ),
                              color: AppColor.colorPrimary,
                              strokeWidth: 0.5,
                              strokeRadius: 3.0,
                              edgeInsets: EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 2.0),
                            ),
                          ],
                        ),
                      ),
                new Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      widget.haveImg && articleData != null
                          ? new Container(
                              child: new Image(
                                  height: 16.0,
                                  width: 16.0,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      articleData['round_head_img'])),
                            )
                          : new Icon(
                              Icons.person_pin,
                              size: 16.0,
                              color: AppColor.text_color_2,
                            ),
                      new Text(
                        "  ${widget.itemData['author']}       ",
                        style: AppStyles.title_style_3,
                      ),
                      new Icon(
                        Icons.access_time,
                        size: 16.0,
                        color: AppColor.text_color_2,
                      ),
                      new Text(
                        "  ${widget.itemData['niceDate']}",
                        style: AppStyles.title_style_3,
                      ),
//                  GestureDetector(
//                    child: Icon(Icons.favorite_border),
//                  )
                    ],
                  ),
                ),
              ],
            ),
            widget.haveImg && articleData != null
                ? new Container(
                    padding: EdgeInsets.only(right: 14.0),
                    child: new FadeInImage.assetNetwork(
                      image: articleData['cdn_url'],
                      placeholder: "images/article_default.png",
                      height: 63.0,
                      width: 63.0,
                      fit: BoxFit.fill,
                    ),
                  )
                : new Container(),
          ],
        ),
        onTap: () {
          _itemClick(widget.itemData);
        },
      ),
    );
  }

  _itemClick(itemData) async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new ArticleDetailPage(
          title: itemData['title'], url: itemData['link']);
    }));
  }

  //收藏文章
  void collectArticle() {}
}
