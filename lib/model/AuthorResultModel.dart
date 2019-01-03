import 'package:json_annotation/json_annotation.dart';

import 'package:wan_program/model/AuthorModel.dart';
import 'package:wan_program/model/BaseModel.dart';

part 'AuthorResultModel.g.dart';

@JsonSerializable()
class AuthorResultModel extends BaseModel<List<AuthorModel>>{
  AuthorResultModel(List<AuthorModel> data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);


  static AuthorResultModel fromJson(Map<String,dynamic> json) => _$AuthorResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorResultModelToJson(this);
}