import 'package:contacts_manager_ui/data/model/contact_model.dart';
import 'package:contacts_manager_ui/routing/app_router_names.dart';
import 'package:contacts_manager_ui/utils/global_sharedpref.dart';
import 'package:flutter/material.dart';

Widget buildContactListWidget(BuildContext context, ContactModel contact) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        RouteNames.contactScreen,
        arguments: contact,
      );
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[400],
            backgroundImage: (contact.profilePicture != null && contact.profilePicture!.isNotEmpty) ? NetworkImage(
              '${GlobalSharedpref.globalBaseUrl}/${contact.profilePicture}'
            ) : null,
            child: contact.profilePicture == "" ? Icon(
              Icons.person,
              color: Colors.white,
            ) : SizedBox(),
          ),
          SizedBox(width: 16.0),
          Text(
            contact.name ?? '',
            style: TextStyle(
              fontFamily: 'WorkSans',
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    ),
  );
}
