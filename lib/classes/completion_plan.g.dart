// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletionPlan _$CompletionPlanFromJson(Map<String, dynamic> json) =>
    CompletionPlan(
      completionPlanPlanId: (json['completionPlanPlanId'] as num).toInt(),
    )
      ..planContent =
          const RxStringConverter().fromJson(json['planContent'] as String)
      ..importanceLevel =
          $enumDecode(_$ImportanceLevelEnumMap, json['importanceLevel'])
      ..startDateTime = DateTime.parse(json['startDateTime'] as String)
      ..endDateTime = DateTime.parse(json['endDateTime'] as String)
      ..remainingDays =
          const RxStringConverter().fromJson(json['remainingDays'] as String)
      ..checked = const RxBoolConverter().fromJson(json['checked'] as bool)
      ..plans = (json['plans'] as List<dynamic>)
          .map((e) => Plan.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CompletionPlanToJson(CompletionPlan instance) =>
    <String, dynamic>{
      'completionPlanPlanId': instance.completionPlanPlanId,
      'planContent': const RxStringConverter().toJson(instance.planContent),
      'importanceLevel': _$ImportanceLevelEnumMap[instance.importanceLevel]!,
      'startDateTime': instance.startDateTime.toIso8601String(),
      'endDateTime': instance.endDateTime.toIso8601String(),
      'remainingDays': const RxStringConverter().toJson(instance.remainingDays),
      'checked': const RxBoolConverter().toJson(instance.checked),
      'plans': instance.plans,
    };

const _$ImportanceLevelEnumMap = {
  ImportanceLevel.highImportance: 'highImportance',
  ImportanceLevel.middleImportance: 'middleImportance',
  ImportanceLevel.lowImportance: 'lowImportance',
  ImportanceLevel.none: 'none',
};
