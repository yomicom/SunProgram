import 'package:json_annotation/json_annotation.dart';

part 'AuthorModel.g.dart';

@JsonSerializable()
class AuthorModel{
  List<String> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  AuthorModel({
    this.children,this.courseId,this.id,this.name,this.order,this.parentChapterId,this.userControlSetTop,this.visible,
  });

  static AuthorModel fromJson(Map<String,dynamic> json) => _$AuthorModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorModelToJson(this);
}