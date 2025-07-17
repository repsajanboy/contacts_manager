import 'package:contacts_manager_ui/blocs/bloc_barrel.dart';
import 'package:contacts_manager_ui/presentation/contact_list/view/widget/contact_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactListBloc()..add(ContactListFetched()),
      child: Scaffold(
        body: BlocBuilder<ContactListBloc, ContactListState>(
          builder: (context, state) {
            return SafeArea(
              child: Container(
                padding: EdgeInsets.only(top: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Contacts',
                        style: TextStyle(
                          fontSize: 48.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.contacts.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          if (state.contacts.isEmpty) {
                            return Center(
                              child: Text('No contacts yet. Press + to add'),
                            );
                          }

                          final contact = state.contacts[index];
                          return buildContactListWidget(context, contact);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
