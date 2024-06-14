import 'package:chuva_dart/pages/activity.dart';
import 'package:flutter/material.dart';
import 'package:chuva_dart/model/models.dart';
import 'package:chuva_dart/controller/data_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:from_css_color/from_css_color.dart';

class PersonPage extends StatefulWidget {
  final String activityId;
  const PersonPage({required this.activityId, Key? key}) : super(key: key);

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late Future<Activity> futureActivity;
  late Future<ActivityData> futureActivities;
  String? authorHash;

  @override
  void initState() {
    super.initState();
    futureActivities = fetchActivities();
    futureActivity = fetchActivityById(widget.activityId);
    futureActivity.then((activity) {
      if (activity.people.isNotEmpty) {
        setState(() {
          authorHash = activity.people[0].hash;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          fetchAuthorData(),
          buildAuthorActivities(),
        ],
      ),
    );
  }

  FutureBuilder<Activity> fetchAuthorData() {
    return FutureBuilder<Activity>(
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
    );
  }

  Expanded buildAuthorActivities() {
    return Expanded(
      child: FutureBuilder<ActivityData>(
        future: futureActivities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro em person/buildAuthorActivities: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var filteredActivities = snapshot.data!.data.where((activity) {
              return activity.people.isNotEmpty && activity.people[0].hash == authorHash;
            }).toList();

            return ListView.builder(
              itemCount: filteredActivities.length,
              itemBuilder: (context, index) {
                var activity = filteredActivities[index];
                final startTime = DateTime.parse(activity.start);
                final endTime = DateTime.parse(activity.end);
                final formattedStartTime = '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
                final formattedEndTime = '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';

                return InkWell(
                  onTap: () {
                    context.push('/activity/${activity.id}');
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: (activity.title.ptBr.length < 70) ? 120 : 190,
                          decoration: BoxDecoration(
                            color: activity.category.color.isNotEmpty ? fromCssColor(activity.category.color) : Colors.blue,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${activity.type.title.ptBr} de $formattedStartTime até $formattedEndTime',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  activity.title.ptBr,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                if (activity.people.isNotEmpty)
                                  Text(
                                    'Autor: ${activity.people[0].name}',
                                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Erro ao carregar, nenhuma atividade foi encontrada'));
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

  String getDayOfWeekAbrv(DateTime dt) {
    if (dt.day == 26) return 'dom.';
    if (dt.day == 27) return 'seg.';
    if (dt.day == 28) return 'ter.';
    if (dt.day == 29) return 'qua.';
    return 'qui.';
  }

  Widget buildActivityContent(Activity activity) {
    final startTime = DateTime.parse(activity.start);
    final formattedStartTime = '${startTime.day.toString()}/${startTime.month.toString()}/${startTime.year.toString()}';
    String pictureURL = "";
    final personName = activity.people.isNotEmpty ? activity.people[0].name : '';
    final universityName = activity.people.isNotEmpty ? activity.people[0].institution : '';
    final bio = activity.people.isNotEmpty ? activity.people[0].bio.ptBr : '';
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
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      personName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    Text(
                      universityName,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Bio',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              bio.replaceAll(RegExp(r'<[^>]*>'), ''),
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Atividades',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              '${getDayOfWeekAbrv(startTime)}, $formattedStartTime',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2.0),
          ],
        ),
      ),
    );
  }
}
