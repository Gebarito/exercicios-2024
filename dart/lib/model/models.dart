class ActivityData {
  int count;
  // Links links;
  List<Activity> data;

  ActivityData({
    required this.count, 
    // required this.links, 
    required this.data});

  factory ActivityData.fromJson(Map<String, dynamic> json) {
    return ActivityData(
      count: json['count'],
      // links: Links.fromJson(json['links']),
      data: List<Activity>.from(json['data'].map((x) => Activity.fromJson(x))),
    );
  }
}

// class Links {
//   String self;
//   String next;

//   Links({required this.self, required this.next});

//   factory Links.fromJson(Map<String, dynamic> json) {
//     return Links(
//       self: json['self'] ?? '',
//       next: json['next'] ?? '',
//     );
//   }
// }

class Activity {
  int id;
  int changed;
  String start;
  String end;
  Title title;
  Description description;
  Category category;
  List<Location> locations;
  Type type;
  List<dynamic> papers;
  List<Person> people;
  int status;
  int weight;
  dynamic addons;
  dynamic parent;
  String event;

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
    this.addons,
    this.parent,
    required this.event,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      changed: json['changed'],
      start: json['start'] ?? '',
      end: json['end'] ?? '',
      title: Title.fromJson(json['title']),
      description: Description.fromJson(json['description']),
      category: Category.fromJson(json['category']),
      locations: List<Location>.from(json['locations'].map((x) => Location.fromJson(x))),
      type: Type.fromJson(json['type']),
      papers: List<dynamic>.from(json['papers']),
      people: List<Person>.from(json['people'].map((x) => Person.fromJson(x))),
      status: json['status'],
      weight: json['weight'],
      addons: json['addons'],
      parent: json['parent'],
      event: json['event'] ?? '',
    );
  }
}

class Title {
  String ptBr;

  Title({required this.ptBr});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
      ptBr: json['pt-br'] ?? '',
    );
  }
}

class Description {
  String ptBr;

  Description({required this.ptBr});

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
      ptBr: json['pt-br'] ?? '',
    );
  }
}

class Category {
  int id;
  Title title;
  String color;
  String backgroundColor;

  Category({
    required this.id,
    required this.title,
    required this.color,
    required this.backgroundColor,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: Title.fromJson(json['title']),
      color: json['color'] ?? '',
      backgroundColor: json['background-color'] ?? '',
    );
  }
}

class Location {
  int id;
  Title title;
  int parent;
  dynamic map;

  Location({
    required this.id,
    required this.title,
    required this.parent,
    this.map,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      title: Title.fromJson(json['title']),
      parent: json['parent'],
      map: json['map'],
    );
  }
}

class Type {
  int id;
  Title title;

  Type({required this.id, required this.title});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: json['id'],
      title: Title.fromJson(json['title']),
    );
  }
}

class Person {
  int id;
  String title;
  String name;
  String institution;
  Bio bio;
  String picture;
  int weight;
  Role role;
  String hash;

  Person({
    required this.id,
    required this.title,
    required this.name,
    required this.institution,
    required this.bio,
    required this.picture,
    required this.weight,
    required this.role,
    required this.hash,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      title: json['title'] ?? '',
      name: json['name'] ?? '',
      institution: json['institution'] ?? '',
      bio: Bio.fromJson(json['bio']),
      picture: json['picture'] ?? '',
      weight: json['weight'],
      role: Role.fromJson(json['role']),
      hash: json['hash'] ?? '',
    );
  }
}

class Bio {
  String ptBr;

  Bio({required this.ptBr});

  factory Bio.fromJson(Map<String, dynamic> json) {
    return Bio(
      ptBr: json['pt-br'] ?? '',
    );
  }
}

class Role {
  int id;
  Label label;

  Role({required this.id, required this.label});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      label: Label.fromJson(json['label']),
    );
  }
}

class Label {
  String ptBr;

  Label({required this.ptBr});

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      ptBr: json['pt-br'] ?? '',
    );
  }
}
