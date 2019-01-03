import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImagePreViewPage extends StatelessWidget {
  final String url;

  const ImagePreViewPage({
    Key key,
    @required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
          alignment: Alignment.center,
            color: Colors.black,
            child: new GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Hero(
                  tag: url,
                  child: CachedNetworkImage(imageUrl: url),
                ))));
  }
}
