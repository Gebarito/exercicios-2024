import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
  int id;
  String title;
  String name;
  String institution;
  Map<String, dynamic> bio; // Usando ? para permitir nulos
  String picture;
  int weight;
  Map<String, dynamic> role; // Também marque role como nulo se desejar
  String hash;

  Person(
  {
      required this.id,
      required this.title,
      required this.name,
      required this.institution,
      required this.bio,
      required this.picture,
      required this.weight,
      required this.role,
      required this.hash
    }
  );

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
