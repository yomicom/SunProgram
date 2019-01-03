// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PicInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PicInfo _$PicInfoFromJson(Map<String, dynamic> json) {
  return PicInfo(
      title: json['title'] as String,
      pic_id: json['pic_id'] as String,
      ding: json['ding'] as String,
      cai: json['cai'] as String,
      old: json['old'] as String,
      cover_url: json['cover_url'] as String,
      file_url: json['file_url'] as String,
      file_width: json['file_width'] as String,
      file_height: json['file_height'] as String,
      url: json['url'] as String,
      source: json['source'] as String,
      mp4_url: json['mp4_url'] as String,
      video_url: json['video_url'] as String,
      sort: json['sort'] as String,
      cmt_md5: json['cmt_md5'] as String,
      cmt_url: json['cmt_url'] as String,
      add_intro: json['add_intro'] as String);
}

Map<String, dynamic> _$PicInfoToJson(PicInfo instance) => <String, dynamic>{
      'title': instance.title,
      'pic_id': instance.pic_id,
      'ding': instance.ding,
      'cai': instance.cai,
      'old': instance.old,
      'cover_url': instance.cover_url,
      'file_url': instance.file_url,
      'file_width': instance.file_width,
      'file_height': instance.file_height,
      'url': instance.url,
      'source': instance.source,
      'mp4_url': instance.mp4_url,
      'video_url': instance.video_url,
      'sort': instance.sort,
      'cmt_md5': instance.cmt_md5,
      'cmt_url': instance.cmt_url,
      'add_intro': instance.add_intro
    };
