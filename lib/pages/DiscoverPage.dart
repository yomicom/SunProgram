import 'package:flutter/material.dart';
import 'package:wan_program/common/Api.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:wan_program/common/HttpUtils.dart';
import 'package:wan_program/pages/ArticlesPage.dart';
import 'package:wan_program/common/styles.dart';

class DiscoverPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DiscoverPageState();
  }
}

class DiscoverPageState extends State<DiscoverPage> {
  var listData;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new ListView.builder(
        itemBuilder: (context, i) => buildItem(i),
        itemCount: listData.length,
      );
    }
  }

  //获取数据
  void _getData() async {
//    Dio dio = new Dio();
//    Response<String> response = await dio.get(Api.BaseUrl + Api.TREE);
//    Map<String, dynamic> map = json.decode(response.data.toString());
//    setState(() {
//      listData = map['data'];
//    });
    HttpUtil.get(Api.TREE, (data) {
      setState(() {
        listData = data;
      });
    });
  }

  //展示数据
  Widget buildItem(i) {
    var itemData = listData[i];
    Text name = new Text(
      itemData['name'],
      softWrap: true,
      textAlign: TextAlign.left,
      style: AppStyles.title_style_1,
    );

    List list = itemData['children'];
    String cont = '';
    for (var value in list) {
      cont += '${value["name"]}   ';
    }

    Text content = new Text(
      cont,
      softWrap: true,
      style: AppStyles.title_style_2,
      textAlign: TextAlign.left,
    );

    return new Card(
      elevation: 4.0,
      child: new InkWell(
        onTap: () {
          _handOnItemClick(itemData);
        },
        child: new Container(
          padding: const EdgeInsets.all(15.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                  child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: name,
                  ),
                  content
                ],
              )),
              new Icon(Icons.navigate_next)
            ],
          ),
        ),
      ),
    );
  }

  void _handOnItemClick(itemData) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new ArticlePage(itemData);
    }));
  }
}
