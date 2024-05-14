import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:chuva_dart/model/paper.dart';

class ActivityCardList extends StatefulWidget {
  @override
  _ActivityCardListState createState() => _ActivityCardListState();
}

class _ActivityCardListState extends State<ActivityCardList> {
  List<Paper> activities = [];

  @override
  void initState() {
    super.initState();
    loadActivities();
  }

  Future<void> loadActivities() async {
    try {
      String jsonString = await rootBundle.loadString('assets/activities.json');
      
      List<dynamic> jsonList = jsonDecode(jsonString);

      List<Paper> loadedActivities = jsonList.map((json) => Paper.fromJson(json)).toList();

      setState(() {
        activities = loadedActivities;
      });
    } catch (e) {
      print('Erro ao carregar atividades: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Atividades'),
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(activities[index].title['default']),
              subtitle: Text(activities[index].description['default']),
              onTap: () {
                // Aqui você pode adicionar a lógica para abrir uma nova tela ou fazer algo quando o cartão for pressionado
              },
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ActivityCardList(),
  ));
}
