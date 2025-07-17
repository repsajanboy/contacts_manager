import 'package:contacts_manager_ui/data/model/contact_model.dart';
import 'package:contacts_manager_ui/presentation/add_contact/add_contact.dart';
import 'package:contacts_manager_ui/presentation/api_configuration/api_configuration.dart';
import 'package:contacts_manager_ui/presentation/contact/contact.dart';
import 'package:contacts_manager_ui/presentation/contact_list/contact_list.dart';
import 'package:contacts_manager_ui/presentation/edit_contact/edit_contact.dart';
import 'package:contacts_manager_ui/routing/app_router_names.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.landing:
        return MaterialPageRoute(
          builder: (_) => ApiConfigurationScreen(),
        );
      case RouteNames.contactListScreen:
        return MaterialPageRoute(
          builder: (_) => ContactListScreen(),
        );
      case RouteNames.contactScreen:
        final contact = routeSettings.arguments as ContactModel;
        return MaterialPageRoute(
          builder: (_) => ContactScreen(contact: contact),
        );
      case RouteNames.addContactScreen:
        return MaterialPageRoute(
          builder: (_) => AddContactScreen(),
        );
      case RouteNames.editContactScreen:
        final contact = routeSettings.arguments as ContactModel;
        return MaterialPageRoute(
          builder: (_) => EditContactScreen(contact: contact),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route define for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}
