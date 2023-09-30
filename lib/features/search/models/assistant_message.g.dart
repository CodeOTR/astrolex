// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssistantMessage _$AssistantMessageFromJson(Map<String, dynamic> json) =>
    AssistantMessage(
      summary: json['summary'] as String?,
      searchTerms: (json['searchTerms'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      date: getDateTimeFromTimestamp(json['date']),
      works: (json['works'] as List<dynamic>?)
          ?.map((e) => Work.fromJson(e as Map<String, dynamic>))
          .toList(),
      concepts: (json['concepts'] as List<dynamic>?)
          ?.map((e) => Concept.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$AssistantMessageToJson(AssistantMessage instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'searchTerms': instance.searchTerms,
      'questions': instance.questions,
      'date': getTimestampFromDateTime(instance.date),
      'works': instance.works?.map((e) => e.toJson()).toList(),
      'concepts': instance.concepts?.map((e) => e.toJson()).toList(),
      'type': instance.type,
    };
