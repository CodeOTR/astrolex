import 'package:astrolex/features/shared/utils/json/utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:openalex/models/models.dart';

part 'assistant_message.g.dart';

@JsonSerializable(explicitToJson: true)
class AssistantMessage {
  String? summary;

  @JsonKey(name: 'searchTerms')
  List<String>? searchTerms;

  List<String>? questions;

  @JsonKey(fromJson: getDateTimeFromTimestamp, toJson: getTimestampFromDateTime)
  DateTime? date;

  List<Work>? works;

  List<Concept>? concepts;

  String? type;

  AssistantMessage({
    this.summary,
    this.searchTerms,
    this.questions,
    this.date,
    this.works,
    this.concepts,
    this.type,
  });

  factory AssistantMessage.fromJson(Map<String, dynamic> json) => _$AssistantMessageFromJson(json);

  Map<String, dynamic> toJson() => _$AssistantMessageToJson(this);
}
