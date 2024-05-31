import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chuva_dart/model/models.dart';

Future<ActivityData> fetchActivities() async {
  final response = await http.get(Uri.parse('https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json'),);
  // final response2 = await http.get(Uri.parse('https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities-1.json'));

  if (response.statusCode == 200) {
    return ActivityData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Atividades não foram carregadas\nData_controller.dart');
  }
}