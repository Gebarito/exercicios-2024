import 'package:json_annotation/json_annotation.dart';

part 'paper.g.dart';

@JsonSerializable()
class Activity {
  final int id;
  final int changed;
  final DateTime start;
  final DateTime end;
  final Map<String, dynamic> title;
  final Map<String, dynamic> description;
  final Map<String, dynamic> category;
  final List<dynamic> locations;
  final Map<String, dynamic> type;
  final List<dynamic> papers;
  final List<dynamic> people;
  final int status;
  final int weight;
  final dynamic addons;
  final dynamic parent;
  final String event;

  Activity({
    required this.id,
    required this.changed,
    required this.start,
    required this.end,
    required this.title,
    required this.description,
    required this.category,
    required this.locations,
    required this.type,
    required this.papers,
    required this.people,
    required this.status,
    required this.weight,
    required this.addons,
    required this.parent,
    required this.event,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
