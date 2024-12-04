// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
      planId: (json['planId'] as num).toInt(),
    )
      ..planContent =
          const RxStringConverter().fromJson(json['planContent'] as String)
      ..important = const RxBoolConverter().fromJson(json['important'] as bool)
      ..checked = const RxBoolConverter().fromJson(json['checked'] as bool)
      ..startDate = DateTime.parse(json['startDate'] as String)
      ..endDate = DateTime.parse(json['endDate'] as String);

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'planId': instance.planId,
      'planContent': const RxStringConverter().toJson(instance.planContent),
      'important': const RxBoolConverter().toJson(instance.important),
      'checked': const RxBoolConverter().toJson(instance.checked),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };
