import 'package:contacts_manager_ui/data/model/contact_model.dart';
import 'package:flutter/material.dart';

Widget buildContactListWidget(BuildContext context, ContactModel contact) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, color: Colors.white,),
        ),
        SizedBox(width: 16.0),
        Text(contact.name ?? '', style: TextStyle(fontSize: 16.0),)
      ],
    ),
  );
}