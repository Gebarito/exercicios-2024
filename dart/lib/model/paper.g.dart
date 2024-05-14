// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paper _$PaperFromJson(Map<String, dynamic> json) => Paper(
      id: (json['id'] as num).toInt(),
      changed: (json['changed'] as num).toInt(),
      start: json['start'] as String,
      end: json['end'] as String,
      title: json['title'] as Map<String, dynamic>,
      description: json['description'] as Map<String, dynamic>,
      category: json['category'] as Map<String, dynamic>,
      locations: json['locations'] as List<dynamic>,
      type: json['type'] as Map<String, dynamic>,
      papers: json['papers'] as List<dynamic>,
      people: json['people'] as List<dynamic>,
      status: (json['status'] as num).toInt(),
      weight: (json['weight'] as num).toInt(),
      addons: json['addons'] as Map<String, dynamic>,
      parent: json['parent'] as String,
      event: json['event'] as String,
    );

Map<String, dynamic> _$PaperToJson(Paper instance) => <String, dynamic>{
      'id': instance.id,
      'changed': instance.changed,
      'start': instance.start,
      'end': instance.end,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'locations': instance.locations,
      'type': instance.type,
      'papers': instance.papers,
      'people': instance.people,
      'status': instance.status,
      'weight': instance.weight,
      'addons': instance.addons,
      'parent': instance.parent,
      'event': instance.event,
    };
