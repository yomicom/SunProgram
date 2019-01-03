import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wan_program/common/color.dart';
import 'package:wan_program/pages/HomePage.dart';
import 'package:wan_program/pages/WeChatPage.dart';
import 'package:wan_program/pages/DiscoverPage.dart';
import 'package:wan_program/pages/MyPicturePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wan_program',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: AppColor.colorPrimary,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _tabIndex = 0;
  int lastTime = 0;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  var _body;
  var tabTitles = ["首页", "公众号", "体系", "图库"];

  Color themeColor = AppColor.colorPrimary;
  List<BottomNavigationBarItem> _navigationViews;
  Drawer myDrawer;

  @override
  void initState() {
    super.initState();
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);

    _navigationViews = <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        title: new Text(tabTitles[0]),
        backgroundColor: AppColor.colorPrimary,
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.web),
        title: new Text(tabTitles[1]),
        backgroundColor: AppColor.colorPrimary,
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.widgets),
        title: new Text(tabTitles[2]),
        backgroundColor: AppColor.colorPrimary,
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.image),
        title: new Text(tabTitles[3]),
        backgroundColor: AppColor.colorPrimary,
      ),
    ];

    myDrawer = new Drawer(
      child: new Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: new Text(
              "流年",
              style: new TextStyle(fontSize: 15),
            ),
            accountEmail: new Text(
              "#没拿到的机会，就不是属于我的机会#",
              style: new TextStyle(fontSize: 12),
            ),
            currentAccountPicture: new CircleAvatar(
              backgroundImage: new NetworkImage(//头像
                  "https://pic3.zhimg.com/v2-b783a3fd1cd8c1d0052c385076bc447a_xll.jpg"),
            ),
            //背景图
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(
                        "https://pic1.zhimg.com/80/14a75ae0cc5c99c7cf35747720f46fb4_hd.jpg"))),
          ),
          ListTile(
            leading: new Icon(Icons.help),
            title: new Text("帮助"),
            onTap: null,
          ),
          ListTile(
            leading: new Icon(Icons.settings),
            title: new Text("设置"),
            onTap: null,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    intData();
//    return new WillPopScope(
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(
          tabTitles[_tabIndex],
          style: new TextStyle(color: Colors.white),
        ),
        iconTheme: new IconThemeData(color: Colors.white),
        actions: <Widget>[
//          new IconButton(
//              icon: new Icon(
//                Icons.search,
//                color: Colors.white,
//              ),
//              onPressed: null)
        ],
      ),
      body: _body,
      bottomNavigationBar: new BottomNavigationBar(
        items: _navigationViews
            .map((BottomNavigationBarItem item) => item)
            .toList(),
        currentIndex: _tabIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),

      drawer:
          myDrawer, // This trailing comma makes auto-formatting nicer for build methods.
    );
//        onWillPop: () {
//          if (Navigator.canPop(context)) {
//            Navigator.pop(context);
//          } else {
//            int newTime = DateTime.now().millisecondsSinceEpoch;
//            int result = newTime - lastTime;
//            lastTime = newTime;
//            if (result > 2000) {
//              _globalKey.currentState
//                  .showSnackBar(SnackBar(content: Text('再按一次退出系统！')));
//            } else {
//              SystemNavigator.pop();
//            }
//          }
//          return null;
//        });
  }

  void intData() {
    _body = new IndexedStack(
      children: <Widget>[
        new HomePage(),
        new WeChatPage(),
        new DiscoverPage(),
        new MyPicturePage()
      ],
      index: _tabIndex,
    );
  }
}
