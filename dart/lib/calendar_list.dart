import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Classe para representar os objetos no JSON
// Classe para representar os objetos no JSON
class Activity {
  final int id;
  final String title;
  final String description;

  Activity({required this.id, required this.title, required this.description});

  factory Activity.fromJson(Map<String, dynamic> json) {
    try {
      final id = json['id'] ?? -1;
      final title = json['title']?['pt-br'] ?? 'No Title';
      final description = json['description']?['pt-br'] ?? 'No Description';

      return Activity(
        id: id,
        title: title,
        description: description,
      );
    } catch (e) {
      print('Error parsing JSON: $e');
      throw Exception('Failed to parse activity');
    }
  }
}


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Atividades',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ActivityList(),
    );
  }
}

class ActivityList extends StatefulWidget {
  @override
  _ActivityListState createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  late Future<List<Activity>> futureActivities;

  @override
  void initState() {
    super.initState();
    futureActivities = fetchActivities();
  }

  Future<List<Activity>> fetchActivities() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body)['data'];
      return jsonList.map((json) => Activity.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load activities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Atividades'),
      ),
      body: Center(
        child: FutureBuilder<List<Activity>>(
          future: futureActivities,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].title),
                    subtitle: Text(snapshot.data![index].description),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}