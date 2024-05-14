import 'package:json_annotation/json_annotation.dart';

part 'paper.g.dart';

@JsonSerializable()
class Paper {
  int id;
  int changed;
  String start;
  String end;
  Map<String, dynamic> title;
  Map<String, dynamic> description;
  Map<String, dynamic> category;
  List<dynamic> locations;
  Map<String, dynamic> type;
  List<dynamic> papers;
  List<dynamic> people;
  int status;
  int weight;
  Map<String, dynamic> addons;
  String parent;
  String event;

  Paper({
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
    required this.event
  });

  factory Paper.fromJson(Map<String, dynamic> json) => _$PaperFromJson(json);

  Map<String, dynamic> toJson() => _$PaperToJson(this);
}