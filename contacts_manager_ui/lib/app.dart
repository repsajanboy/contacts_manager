import 'package:contacts_manager_ui/routing/app_router.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});

  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Manager App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}