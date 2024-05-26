import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _currentDate = DateTime(2023, 11, 26);
  bool _clicked = false;

  void _changeDate(DateTime newDate) {
    setState(() {
      _currentDate = newDate;
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromRGBO(69, 97, 137, 1),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Chuva 💜 Flutter',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 4),
          const Text(
            'Programação',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 4),
          OutlinedButton(
            onPressed: (){},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_month_outlined),
                SizedBox(width: 4),
                Text(
                  'Exibindo todas as atividades',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                )
              ],
            ),
          ),
        ],
      ),
      centerTitle: true,
      toolbarHeight: 100,
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 1),
            color: const Color(0xFF306DC3),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.white,
                  child: const Column(
                    children: [
                      Text(
                        'Nov',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '2023',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    for (int day = 26; day <= 30; day++)
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.133,
                        ),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(5),
                            side: const BorderSide(
                              style: BorderStyle.none,
                            ),
                          ),
                          onPressed: () {
                            _changeDate(DateTime(2023, 11, day));
                          },
                          child: Text(
                            day.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: _currentDate.day == day
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
 
          // logica de negocios
          //SET DAY STATES
          if (_currentDate.day == 26)
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _clicked = true;
                });
              },
              child: const Text('Mesa redonda de 07:00 até 08:00'),
            ),
          if(_currentDate.day == 27)
            OutlinedButton(onPressed: (){
              setState(() {
                _clicked = true;
                });
              }, 
              child: const Text("dia 27")
            ),
          if (_currentDate.day == 28)
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _clicked = true;
                });
              },
              child: const Text('Palestra de 09:30 até 10:00'),
            ),
          if (_currentDate.day == 29)
            OutlinedButton(onPressed: (){
              setState(() {
                _clicked = true;
              });
            }, 
            child: const Text("dia 29") 
          ),
          if (_currentDate.day == 30)
            OutlinedButton(onPressed: (){
              setState(() {
                _clicked = true;
              });
            }, 
            child: const Text("dia 30")
          ),
          if (_currentDate.day == 26 && _clicked) const Activity(),
          // END DAY STATES
        
        
        ],
      ),
    ),
  );
}
}



class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  bool _favorited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(69, 97, 137, 1), // Alterando a cor de fundo para RGB (69, 97, 137)
      child: Column(children: [
        const Text(
          'Activity title',
          style: TextStyle(color: Colors.white),
        ),
        const Text('A Física dos Buracos Negros Supermassivos'),
        const Text('Mesa redonda'),
        const Text('Domingo 07:00h - 08:00h'),
        const Text('Sthepen William Hawking'),
        const Text('Maputo'),
        const Text('Astrofísica e Cosmologia'),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _favorited = !_favorited;
            });
          },
          icon: _favorited
              ? const Icon(Icons.star)
              : const Icon(Icons.star_outline),
          label: Text(
              _favorited ? 'Remover da sua agenda' : 'Adicionar à sua agenda'),
        )
      ]),
    );
  }
}
