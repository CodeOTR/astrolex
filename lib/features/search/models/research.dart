import 'package:astrolex/features/shared/utils/json/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'research.g.dart';

@JsonSerializable(explicitToJson: true)
class Research {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'goal')
  String goal;

  @JsonKey(name: 'searchTerm')
  String searchTerm;

  @JsonKey(name: 'date', fromJson: getDateTimeFromTimestamp, toJson: getTimestampFromDateTime)
  DateTime? date;

  Research({
    required this.id,
    required this.goal,
    required this.searchTerm,
    required this.date,
  });

  factory Research.fromJson(Map<String, dynamic> json) => _$ResearchFromJson(json);

  Map<String, dynamic> toJson() => _$ResearchToJson(this);
}
