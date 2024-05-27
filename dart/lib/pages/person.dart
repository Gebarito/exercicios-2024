import 'package:flutter/material.dart';
import 'package:chuva_dart/model/models.dart';
import 'package:chuva_dart/controller/data_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PersonPage extends StatefulWidget {
  final String activityId;

  const PersonPage({required this.activityId, Key? key}) : super(key: key);

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
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
      elevation: 3.3,
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

  Widget buildActivityContent(Activity activity) {
    String pictureURL = "";
    final personName = activity.people[0].name;
    final universityName = activity.people[0].institution;
    final bio = activity.people[0].bio.ptBr;
    if (activity.people.isNotEmpty) {
      pictureURL = activity.people[0].picture;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: CachedNetworkImageProvider(pictureURL),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      personName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      universityName,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Bio',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              bio,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<Activity> fetchActivityById(String id) async {
  final data = await fetchActivities();
  return data.data.firstWhere((activity) => activity.id.toString() == id);
}
