import 'package:chuva_dart/pages/activity.dart';
import 'package:chuva_dart/pages/person.dart';
import 'package:flutter/material.dart';
import 'package:chuva_dart/pages/home.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/activity/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ActivityPage(activityId: id);
        },
      ),
      GoRoute(
        path: '/person/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return PersonPage(activityId: id);
        }
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Chuva Dart',
    );
  }
}
