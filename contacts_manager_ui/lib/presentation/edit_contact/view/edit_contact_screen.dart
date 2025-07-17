import 'package:contacts_manager_ui/blocs/bloc_barrel.dart';
import 'package:contacts_manager_ui/data/model/contact_model.dart';
import 'package:contacts_manager_ui/routing/app_router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditContactScreen extends StatelessWidget {
  const EditContactScreen({required this.contact, super.key});

  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditContactBloc(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Delete'),
                        content: Text(
                            'Are you sure you want to delete this contact?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          BlocBuilder<EditContactBloc, EditContactState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  context.read<EditContactBloc>().add(ContactDeleted(id: contact.id));
                                  Navigator.pushNamed(context, RouteNames.contactListScreen);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                child: Text("Delete"),
                              );
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Row(
                children: [
                  Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Center(
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 75,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Name:'), Text(contact.name ?? '')],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email Address:'),
                        Text(contact.email ?? '')
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone Number:'),
                        Text(contact.phoneNumber ?? '')
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
