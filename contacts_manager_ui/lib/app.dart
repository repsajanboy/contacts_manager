import 'package:contacts_manager_ui/data/repository/contact_repository.dart';
import 'package:contacts_manager_ui/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/bloc_barrel.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});

  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ContactRepository>(
          create: (context) => ContactRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ContactListBloc()..add(ContactListFetched()),
          ),
          BlocProvider(
            create: (context) =>
                ApiConfigurationBloc()..add(ApiBaseUrlConfigure()),
          ),
        ],
        child: MaterialApp(
          title: 'Contact Manager App',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: router.onGenerateRoute,
        ),
      ),
    );
  }
}
