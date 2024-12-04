import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

class RxBoolConverter implements JsonConverter<RxBool, bool> {
  const RxBoolConverter();

  @override
  RxBool fromJson(bool json) {
    return RxBool(json);
  }

  @override
  bool toJson(RxBool object) {
    return object.value;
  }
}
