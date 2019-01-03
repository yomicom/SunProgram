import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

/// 文章详情页面
class ArticleDetailPage extends StatefulWidget {
  var title;

  var url;

  @override
  State<StatefulWidget> createState() {
    return new ArticleDetailPageState();
  }

  ArticleDetailPage({Key key, @required this.title, @required this.url})
      : super(key: key);
}

class ArticleDetailPageState extends State<ArticleDetailPage> {
  bool isLoad = true;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onStateChanged.listen((state) {
      debugPrint('state:' + state.type.toString());
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoad = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
    fluwx.register(appId: "1108011901");
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {
              fluwx.share(fluwx.WeChatShareTextModel(
                  text: widget.url,
                  transaction: "transaction}",
                  scene: fluwx.WeChatScene.SESSION
//                  .share(fluwx.WeChatShareWebPageModel(
//                webPage: widget.url,
//                title: widget.title,
//                thumbnail: "http://flutter.link/css/images/logo.png",
              ))
                  .then((result) {
                print("success:" + result.toString());
              }, onError: (msg) {
                print("error:" + msg.toString());
              });
            },
          ),
        ],
        bottom: new PreferredSize(
            child: isLoad
                ? new LinearProgressIndicator(
//                    backgroundColor: Colors.white,
                    )
                : new Divider(
                    height: 0.8,
                    color: Theme.of(context).primaryColor,
                  ),
            preferredSize: const Size.fromHeight(0.8)),
      ),
      withZoom: false,
      withJavascript: true,
      withLocalStorage: true,
    );
  }
}
