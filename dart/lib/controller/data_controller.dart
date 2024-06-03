import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:chuva_dart/model/models.dart';
//import 'package:http/http.dart' as http; dio no lugar para multiples responses

Future<ActivityData> fetchActivities() async {
  final dio = Dio();

  try {
    final response1 = await dio.get('https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json');
    final response2 = await dio.get('https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities-1.json');

    if (response1.statusCode == 200 && response2.statusCode == 200) {
      final data1 = jsonDecode(response1.data);
      final data2 = jsonDecode(response2.data);

      final combinedResponses = {
        'count': data1['count'] + data2['count'],
        'data': [...data1['data'], ...data2['data']]
      };

      return ActivityData.fromJson(combinedResponses);
    } else {
      throw Exception('Atividades não foram carregadas\nData_controller.dart');
    }
  } catch (e) {
    throw Exception('Erro ao carregar atividades: $e');
  }
}
