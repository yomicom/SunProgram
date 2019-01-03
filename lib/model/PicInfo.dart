import 'package:json_annotation/json_annotation.dart';

part 'PicInfo.g.dart';

@JsonSerializable(nullable: false)
class PicInfo{
  String title;
  String pic_id;
  String ding;
  String cai;
  String old;
  String cover_url;
  String file_url;
  String file_width;
  String file_height;
  String url;
  String source;
  String mp4_url;
  String video_url;
  String sort;
  String cmt_md5;
  String cmt_url;
  String add_intro;

  PicInfo({
    this.title,this.pic_id,this.ding,this.cai,this.old,this.cover_url,this.file_url,this.file_width,this.file_height,this.url,this.source,this.mp4_url,this.video_url,this.sort,this.cmt_md5,this.cmt_url,this.add_intro,
  });

  factory PicInfo.fromJson(Map<String, dynamic> json) => _$PicInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PicInfoToJson(this);
}