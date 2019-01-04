import 'package:json_annotation/json_annotation.dart';
import 'package:wan_program/model/HomeBannerItemModel.dart';
import 'package:wan_program/model/BaseModel.dart';

part 'HomeBannerModel.g.dart';

@JsonSerializable()
class HomeBannerModel extends BaseModel<List<HomeBannerItemModel>> {
  HomeBannerModel(
      List<HomeBannerItemModel> data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory HomeBannerModel.fromJson(Map<String, dynamic> json) =>
      _$HomeBannerModelFromJson(json);

  toJson() => _$HomeBannerModelToJson(this);
}
