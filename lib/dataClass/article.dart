import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  int? code;
  List<Data>? data;

  Article({
    this.code,
    this.data,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class Data {
  String? title;
  @JsonKey(name: 'img_res')
  String? imgRes;
  String? location;
  String? price;

  Data({
    this.title,
    this.imgRes,
    this.location,
    this.price,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
