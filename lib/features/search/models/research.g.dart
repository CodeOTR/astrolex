// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Research _$ResearchFromJson(Map<String, dynamic> json) => Research(
      id: json['id'] as String,
      goal: json['goal'] as String,
      searchTerm: json['searchTerm'] as String,
      date: getDateTimeFromTimestamp(json['date']),
    );

Map<String, dynamic> _$ResearchToJson(Research instance) => <String, dynamic>{
      'id': instance.id,
      'goal': instance.goal,
      'searchTerm': instance.searchTerm,
      'date': getTimestampFromDateTime(instance.date),
    };
