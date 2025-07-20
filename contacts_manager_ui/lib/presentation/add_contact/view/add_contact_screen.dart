import 'dart:io';

import 'package:contacts_manager_ui/blocs/bloc_barrel.dart';
import 'package:contacts_manager_ui/routing/app_router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddContactScreen extends StatelessWidget {
  AddContactScreen({super.key});

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddContactBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'New Contact',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      BlocBuilder<AddContactBloc, AddContactState>(
                        builder: (context, state) {
                          return CircleAvatar(
                            backgroundColor: Colors.grey[400],
                            backgroundImage: state.profilePicture != null
                                ? FileImage(state.profilePicture!)
                                : null,
                            radius: 60.0,
                            child: state.profilePicture == null
                                ? Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 75,
                                  )
                                : null,
                          );
                        },
                      ),
                      SizedBox(height: 5.0),
                      BlocBuilder<AddContactBloc, AddContactState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () async {
                              final pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (pickedFile != null) {
                                if (!context.mounted) {
                                  return;
                                }
                                context.read<AddContactBloc>().add(
                                    AddContactProfilePictureChanged(
                                        profilePicture: File(pickedFile.path)));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              foregroundColor: Colors.white,
                            ),
                            child: SizedBox(
                              width: 100,
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
                                    'Add Photo',
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
                SizedBox(height: 20.0),
                Text(
                  'Name:',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 18.0,
                  ),
                ),
                BlocBuilder<AddContactBloc, AddContactState>(
                  builder: (context, state) {
                    return TextField(
                      cursorColor: Colors.black,
                      style: TextStyle(fontFamily: 'WorkSans'),
                      decoration: InputDecoration(
                        hintText: 'Enter full name',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        context
                            .read<AddContactBloc>()
                            .add(AddContactNameChanged(name: value));
                      },
                    );
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'Email Address:',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                BlocBuilder<AddContactBloc, AddContactState>(
                  builder: (context, state) {
                    return TextField(
                      cursorColor: Colors.black,
                      style: TextStyle(fontFamily: 'WorkSans'),
                      decoration: InputDecoration(
                        hintText: 'Enter email address',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        context
                            .read<AddContactBloc>()
                            .add(AddContactEmailChanged(email: value));
                      },
                    );
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'Phone Number:',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                BlocBuilder<AddContactBloc, AddContactState>(
                  builder: (context, state) {
                    return TextField(
                      cursorColor: Colors.black,
                      style: TextStyle(fontFamily: 'WorkSans'),
                      decoration: InputDecoration(
                        hintText: 'Enter phone number',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        context.read<AddContactBloc>().add(
                            AddContactPhoneNumberChanged(phoneNumber: value));
                      },
                    );
                  },
                ),
                SizedBox(height: 20.0),
                BlocBuilder<AddContactBloc, AddContactState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          context
                              .read<AddContactBloc>()
                              .add(AddContactSubmitted());
                          BlocProvider.of<ContactListBloc>(context)
                              .add(ContactListFetched());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Contact has been added!'),
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
                          backgroundColor: Color(0xff023563),
                          foregroundColor: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Submit',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
