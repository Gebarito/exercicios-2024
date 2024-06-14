import 'package:flutter/material.dart';
import 'package:chuva_dart/controller/data_controller.dart';
import 'package:chuva_dart/model/models.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentDay = '26';
  late Future<ActivityData> futureActivities;

  @override
  void initState() {
    super.initState();
    futureActivities = fetchActivities();
  }

  void changeDate(String day) {
    setState(() {
      currentDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          buttonSection(),
          buildActivities(),
        ],
      ),
    );
  }

  Row buttonSection() {
    return Row(
      children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Nov'),
            Text(
              '2023',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            color: Colors.blue.shade800,
            child: Row(
              children: [
                Expanded(child: dateButton('26')),
                Expanded(child: dateButton('27')),
                Expanded(child: dateButton('28')),
                Expanded(child: dateButton('29')),
                Expanded(child: dateButton('30')),
              ],
            ),
          ),
        ),
      ],
    );
  }

  OutlinedButton dateButton(String day) {
    return OutlinedButton(
      onPressed: () {
        changeDate(day);
      },
      style: OutlinedButton.styleFrom(
        fixedSize: const Size.fromHeight(40),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        side: BorderSide.none,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      child: Text(
        day,
        style: TextStyle(
          color: Colors.white,
          fontWeight: currentDay == day ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Column(
          children: [
            const Text(
              'Programação',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 5.0),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.elliptical(30, 45)),
                    ),
                    child: const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Exibindo todas as atividades',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
      ),
      elevation: 0.0,
      backgroundColor: Colors.indigo.shade800, //deepPurple.shade900 ????
    );
  }


  
Expanded buildActivities() {
    return Expanded(
      child: FutureBuilder<ActivityData>(
        future: futureActivities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro em home/buildActivities: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var filteredActivities = snapshot.data!.data.where((activity) {
              var activityDate = DateTime.parse(activity.start);
              return activityDate.day.toString() == currentDay;
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
                  child: Container(
                    decoration: BoxDecoration(                    
                      borderRadius: BorderRadius.circular(3),
                      border: Border(
                        left: BorderSide(
                            color: activity.category.color != '' ? fromCssColor(activity.category.color) : Colors.blue,
                            width: 5,
                          ),
                        ),
                      ),
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${activity.type.title.ptBr} de $formattedStartTime até $formattedEndTime',
                                  style: const TextStyle(
                                    fontSize: 12, 
                                    color: Colors.black
                                    ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  activity.title.ptBr,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                if (activity.people.isNotEmpty)
                                  Text(
                                    activity.people[0].name,
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
  
  
// Expanded buildActivities() {
//     return Expanded(
//       child: FutureBuilder<ActivityData>(
//         future: futureActivities,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Erro em home/buildActivities: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             var filteredActivities = snapshot.data!.data.where((activity) {
//               var activityDate = DateTime.parse(activity.start);
//               return activityDate.day.toString() == currentDay;
//             }).toList();

//             return ListView.builder(
//               itemCount: filteredActivities.length,
//               itemBuilder: (context, index) {
//                 var activity = filteredActivities[index];
//                 final startTime = DateTime.parse(activity.start);
//                 final endTime = DateTime.parse(activity.end);
//                 final formattedStartTime = '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
//                 final formattedEndTime = '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';

//                 return InkWell(
//                   onTap: () {
//                     context.push('/activity/${activity.id}');
//                   },
//                   child: Card(
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                     elevation: 2,
//                     margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 5,
//                           height: (activity.title.ptBr.length < 70) ? 114 : 173, 
//                           decoration: BoxDecoration(
//                             color: activity.category.color != '' ? fromCssColor(activity.category.color) : Colors.blue,
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(15),
//                               bottomLeft: Radius.circular(15),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   '${activity.type.title.ptBr} de $formattedStartTime até $formattedEndTime',
//                                   style: const TextStyle(
//                                     fontSize: 12, 
//                                     color: Colors.black
//                                     ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   activity.title.ptBr,
//                                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 if (activity.people.isNotEmpty)
//                                   Text(
//                                     activity.people[0].name,
//                                     style: const TextStyle(fontSize: 14, color: Colors.grey),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const Center(child: Text('Erro ao carregar, nenhuma atividade foi encontrada'));
//           }
//         },
//       ),
//     );
//   }
  

}
