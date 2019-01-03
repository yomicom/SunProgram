import 'package:json_annotation/json_annotation.dart';
import 'package:wan_program/model/PicInfo.dart';

part 'PictureGalleryModel.g.dart';

@JsonSerializable()
class PictureGalleryModel {
  String gallery_title;
  String updated;
  List<PicInfo> picInfo;
  List<String> hiidoId;

  PictureGalleryModel({
    this.gallery_title,
    this.updated,
    this.picInfo,
    this.hiidoId,
  });

  static PictureGalleryModel fromJson(Map<String, dynamic> json) =>_$PictureGalleryModelFromJson(json);

  Map<String, dynamic> toJson() => _$PictureGalleryModelToJson(this);
}
