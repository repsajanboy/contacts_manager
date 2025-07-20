import 'dart:io';

import 'package:contacts_manager_ui/blocs/bloc_barrel.dart';
import 'package:contacts_manager_ui/data/model/contact_model.dart';
import 'package:contacts_manager_ui/routing/app_router_names.dart';
import 'package:contacts_manager_ui/utils/global_sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditContactScreen extends StatelessWidget {
  EditContactScreen({required this.contact, super.key});

  final ContactModel contact;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditContactBloc()..add(EditContactInitialized(contact: contact)),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Confirm Delete',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                          ),
                        ),
                        content: Text(
                          'Are you sure you want to delete this contact?',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          BlocBuilder<EditContactBloc, EditContactState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<EditContactBloc>()
                                      .add(ContactDeleted(id: contact.id));
                                  BlocProvider.of<ContactListBloc>(context)
                                      .add(ContactListFetched());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Contact has been deleted!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  Navigator.pushNamed(
                                          context, RouteNames.contactListScreen)
                                      .then((_) {
                                    if (!context.mounted) {
                                      return;
                                    }
                                    BlocProvider.of<ContactListBloc>(context)
                                        .add(ContactListFetched());
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontFamily: 'WorkSans',
                                  ),
                                ),
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
                      fontFamily: 'Nunito',
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
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Center(
                child: Column(
                  children: [
                    BlocBuilder<EditContactBloc, EditContactState>(
                      builder: (context, state) {
                        return CircleAvatar(
                          radius: 60.0,
                          backgroundColor: Colors.grey[400],
                          backgroundImage: (state.updateProfilePicture != null)
                              ? FileImage(state.updateProfilePicture!)
                              : (state.profilePicture != null &&
                                      state.profilePicture!.isNotEmpty)
                                  ? NetworkImage(
                                      '${GlobalSharedpref.globalBaseUrl}/${contact.profilePicture}')
                                  : null,
                          child: state.profilePicture == ""
                              ? Icon(
                                  Icons.person,
                                  size: 75,
                                  color: Colors.white,
                                )
                              : null,
                        );
                      },
                    ),
                    SizedBox(height: 5.0),
                    BlocBuilder<EditContactBloc, EditContactState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () async {
                            final pickedFile = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (pickedFile != null) {
                              if (!context.mounted) {
                                return;
                              }
                              context.read<EditContactBloc>().add(
                                  EditContactProfilePictureChanged(
                                      updateProfilePicture:
                                          File(pickedFile.path)));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.white,
                          ),
                          child: SizedBox(
                            width: 90,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo_camera_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  'Edit Photo',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
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
                      children: [
                        BlocBuilder<EditContactBloc, EditContactState>(
                          builder: (context, state) {
                            return TextFormField(
                              initialValue: state.name ?? contact.name,
                              cursorColor: Colors.black,
                              style: TextStyle(fontFamily: 'WorkSans'),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_outline),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (value) {
                                context
                                    .read<EditContactBloc>()
                                    .add(EditContactNameChanged(name: value));
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<EditContactBloc, EditContactState>(
                          builder: (context, state) {
                            return TextFormField(
                              initialValue: state.email ?? contact.email,
                              cursorColor: Colors.black,
                              style: TextStyle(fontFamily: 'WorkSans'),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (value) {
                                context
                                    .read<EditContactBloc>()
                                    .add(EditContactEmailChanged(email: value));
                              },
                            );
                          },
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<EditContactBloc, EditContactState>(
                          builder: (context, state) {
                            return TextFormField(
                              initialValue:
                                  state.phoneNumber ?? contact.phoneNumber,
                              cursorColor: Colors.black,
                              style: TextStyle(fontFamily: 'WorkSans'),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone_outlined),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (value) {
                                context.read<EditContactBloc>().add(
                                    EditContactPhoneNumberChanged(
                                        phoneNumber: value));
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            BlocBuilder<EditContactBloc, EditContactState>(
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<EditContactBloc>()
                          .add(EditContactSaved(id: contact.id));
                      final updatedContact = ContactModel(
                        id: state.id,
                        name: state.name,
                        email: state.email,
                        phoneNumber: state.phoneNumber,
                        profilePicture: state.profilePicture,
                        dateCreated: state.dateCreated,
                      );
                      BlocProvider.of<ContactListBloc>(context)
                          .add(ContactListFetched());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Contact has been updated!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(
                        context,
                        RouteNames.contactScreen,
                        arguments: updatedContact,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff023563),
                      foregroundColor: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Update Contact',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
