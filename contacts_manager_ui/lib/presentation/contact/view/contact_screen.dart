import 'package:contacts_manager_ui/data/model/contact_model.dart';
import 'package:contacts_manager_ui/routing/app_router_names.dart';
import 'package:contacts_manager_ui/utils/global_sharedpref.dart';
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
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
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
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: Center(
              child: CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.grey[400],
                backgroundImage: (contact.profilePicture != null &&
                        contact.profilePicture!.isNotEmpty)
                    ? NetworkImage(
                        '${GlobalSharedpref.globalBaseUrl}/${contact.profilePicture}')
                    : null,
                child: contact.profilePicture == ""
                    ? Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 75,
                      )
                    : SizedBox(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Colors.black54,
                          size: 32,
                        ),
                        SizedBox(width: 20.0),
                        Text(
                          contact.name ?? '',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: Colors.black54,
                          size: 32,
                        ),
                        SizedBox(width: 20.0),
                        Text(
                          contact.email ?? '',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 16.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          color: Colors.black54,
                          size: 32,
                        ),
                        SizedBox(width: 20.0),
                        Text(
                          contact.phoneNumber ?? '',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 16.0,
                          ),
                        )
                      ],
                    ),
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
