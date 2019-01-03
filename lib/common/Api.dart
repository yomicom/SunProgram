import 'package:flutter/material.dart';

class Api {
  static const String BaseUrl = "http://www.wanandroid.com/";

  //首页banner
  static const String BANNER = "banner/json";

  //首页文章列表 http://www.wanandroid.com/article/list/0/json
  // 知识体系下的文章http://www.wanandroid.com/article/list/0/json?cid=60
  static const String ARTICLE_LIST = "article/list/";

  //收藏文章列表
  static const String COLLECT_LIST = "lg/collect/list/";

  //公众号作者列表
  static const String AUTHOR_LIST = "wxarticle/chapters/json";

  static final String MP_WECHAT_LIST = "http://wanandroid.com/wxarticle/list/";

  //搜索
  static const String ARTICLE_QUERY = "article/query/";

  //收藏,取消收藏
  static const String COLLECT = "lg/collect/";
  static const String UNCOLLECT_ORIGINID = "lg/uncollect_originId/";

  //我的收藏列表中取消收藏
  static const String UNCOLLECT_LIST = "lg/uncollect/";

  //登录,注册
  static const String LOGIN = "user/login";
  static const String REGISTER = "user/register";

  //知识体系
  static const String TREE = "tree/json";

  //常用网站
  static const String FRIEND = "friend/json";

  //搜索热词
  static const String HOTKEY = "hotkey/json";

  //多玩
  static const String DUOWAN_BaseUrl = "http://tu.duowan.com/";

  //妹纸图片
  static const String GANK_MEIZHI = "http://gank.io/api/data/福利/";
  //搞笑Gif
  static const String DUOWAN_Gif = "m/bxgif?";
  //图片
  static const String DUOWAN_Img = "tag/5037.html?";
  //视频
  static const String DUOWAN_Vedio = "tu?";
  //图库详情
  static const String DUOWAN_Gallery = "index.php?r=show/getByGallery/&gid=";


}
