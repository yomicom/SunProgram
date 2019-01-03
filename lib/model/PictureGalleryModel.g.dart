// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PictureGalleryModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PictureGalleryModel _$PictureGalleryModelFromJson(Map<String, dynamic> json) {
  return PictureGalleryModel(
      gallery_title: json['gallery_title'] as String,
      updated: json['updated'] as String,
      picInfo: (json['picInfo'] as List)
          ?.map((e) =>
              e == null ? null : PicInfo.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      hiidoId: (json['hiidoId'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$PictureGalleryModelToJson(
        PictureGalleryModel instance) =>
    <String, dynamic>{
      'gallery_title': instance.gallery_title,
      'updated': instance.updated,
      'picInfo': instance.picInfo,
      'hiidoId': instance.hiidoId
    };
