import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(includeToJson: false) // toJson에 포함되지 않음
  @JsonKey(name: 'memberId')
  int memberId;
  String name;
  String email;
  String password;

  User({
    required this.memberId,
    required this.name,
    required this.email,
    required this.password,
  });

  // Json 데이터를 가져오기
  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  // User 객체를 Json 형태로 변환
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
