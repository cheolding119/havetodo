import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

class RxListConverter<T> implements JsonConverter<RxList<T>, List<dynamic>> {
  const RxListConverter();

  @override
  RxList<T> fromJson(List<dynamic> json) {
    return RxList<T>(json.cast<T>());
  }

  @override
  List<dynamic> toJson(RxList<T> object) {
    return object.toList();
  }
}
