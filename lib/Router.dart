import 'package:flutter/material.dart';
import 'package:wan_program/pages/ArticleDetailPage.dart';

class Router {
  openWeb(BuildContext context, String url, String title) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return ArticleDetailPage(url: url, title: title);
    }));
  }
}