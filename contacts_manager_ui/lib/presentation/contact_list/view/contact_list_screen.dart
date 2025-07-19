import 'package:contacts_manager_ui/blocs/bloc_barrel.dart';
import 'package:contacts_manager_ui/presentation/contact_list/view/widget/contact_list_widget.dart';
import 'package:contacts_manager_ui/routing/app_router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/api_configuration_edit.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactListBloc()..add(ContactListFetched()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return BlocProvider(
                        create: (context) => ApiConfigurationBloc()
                          ..add(ApiBaseUrlInitialized()),
                        child: apiConfigurationEdit(context),
                      );
                    });
              },
              icon: Icon(
                Icons.settings_outlined,
                color: Color(0xff023563),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.addContactScreen);
          },
          backgroundColor: Color(0xff023563),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Icon(Icons.add),
        ),
        body: BlocBuilder<ContactListBloc, ContactListState>(
          builder: (context, state) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Contacts',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  state.contacts.isEmpty
                      ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Text(
                            'No contacts yet. Press + to add',
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      )
                      : Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.contacts.length,
                            separatorBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              final contact = state.contacts[index];
                              return buildContactListWidget(context, contact);
                            },
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
