import 'package:contacts_manager_ui/blocs/bloc_barrel.dart';
import 'package:contacts_manager_ui/routing/app_router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContactScreen extends StatelessWidget {
  const AddContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddContactBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('New Contact'),
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
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 60.0,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 75.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          'Add Photo',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Name:',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                BlocBuilder<AddContactBloc, AddContactState>(
                  builder: (context, state) {
                    return TextField(
                      cursorColor: Colors.black,
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
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                BlocBuilder<AddContactBloc, AddContactState>(
                  builder: (context, state) {
                    return TextField(
                      cursorColor: Colors.black,
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
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 8.0),
                BlocBuilder<AddContactBloc, AddContactState>(
                  builder: (context, state) {
                    return TextField(
                      cursorColor: Colors.black,
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
