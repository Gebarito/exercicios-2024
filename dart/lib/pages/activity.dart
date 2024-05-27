import 'package:flutter/material.dart';
import 'package:chuva_dart/model/models.dart';
import 'package:chuva_dart/controller/data_controller.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

class ActivityPage extends StatefulWidget {
  final String activityId;

  const ActivityPage({required this.activityId, Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late Future<Activity> futureActivity;

  @override
  void initState() {
    super.initState();
    futureActivity = fetchActivityById(widget.activityId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: FutureBuilder<Activity>(
        future: futureActivity,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar atividade: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Activity activity = snapshot.data!;
            return buildActivityContent(activity);
          } else {
            return const Center(child: Text('Atividade não encontrada'));
          }
        },
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Chuva 💜 flutter',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.indigo.shade800,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
      ),
    );
  }

  String getDayOfWeek(Activity activity) {
    DateTime date = DateTime.parse(activity.start);
    if(date.day == 26) return 'Domingo';
    if(date.day == 27) return 'Segunda-feira';
    if(date.day == 28) return 'Terça-feira';
    if(date.day == 29) return 'Quarta-feira';
    return 'Quinta-feira';
  }

  Widget buildActivityContent(Activity activity) {
    final startTime = DateTime.parse(activity.start);
    final endTime = DateTime.parse(activity.end);
    final formattedStartTime = '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
    final formattedEndTime = '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
    String pictureURL = "";
    if(activity.people.isNotEmpty){
      pictureURL = activity.people[0].picture;
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 20,
            color: activity.category.color != '' ? fromCssColor(activity.category.color) : Colors.pink,
            child: Text(
              activity.type.title.ptBr,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              activity.title.ptBr,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time_outlined,
                  color: Colors.blue,
                ),
                const SizedBox(width: 8),
                Text(
                  '${getDayOfWeek(activity)} $formattedStartTime - $formattedEndTime',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.blue,
                ),
                const SizedBox(width: 8),
                Text(
                  'Localização: ${activity.locations[0].title.ptBr}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: OutlinedButton(
              onPressed: () {
                final snackBar = SnackBar(
                  content: const Text('Vamos te lembrar dessa atividade'),
                  action: SnackBarAction(
                    label: '',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                side: BorderSide.none,
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Adicionar à sua agenda',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              activity.description.ptBr.replaceAll(RegExp(r'<[^>]*>'), ''),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Moderador',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 5),
            child: Card(
              elevation: 0.0,
              child: ListTile(
                onTap: () {
                  if(activity.people.isNotEmpty){
                    context.push('/person/${activity.id}');
                  }
                },
                leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                    pictureURL,
                  ),
                  
                ),
                title: Text(activity.people.isNotEmpty ? activity.people[0].name : 'Nome da Pessoa'),
                subtitle: const Text('Organizador da atividade'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<Activity> fetchActivityById(String id) async {
  final data = await fetchActivities();
  return data.data.firstWhere((activity) => activity.id.toString() == id);
}
