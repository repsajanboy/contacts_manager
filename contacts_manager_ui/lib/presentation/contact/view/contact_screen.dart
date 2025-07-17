import 'package:contacts_manager_ui/data/model/contact_model.dart';
import 'package:contacts_manager_ui/routing/app_router_names.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({required this.contact, super.key});

  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouteNames.editContactScreen,
                arguments: contact,
              );
            },
            child: Row(
              children: [
                Text(
                  'Edit',
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
                SizedBox(width: 5.0),
                Icon(
                  Icons.edit_outlined,
                  color: Colors.black,
                )
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
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
    );
  }
}
