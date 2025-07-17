import 'package:contacts_manager_ui/data/model/contact_model.dart';
import 'package:contacts_manager_ui/data/repository/contact_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'contact_list_event.dart';
part 'contact_list_state.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  ContactListBloc() : super(ContactListState()) {
    on<ContactListFetched>(_fetchContactList);
  }

  final ContactRepository contactRepository = ContactRepository();

  Future<void> _fetchContactList(
    ContactListFetched event,
    Emitter<ContactListState> emit,
  ) async {
    try {
      final contacts = await contactRepository.getAllContacts();
      emit(state.copyWith(contacts: contacts));
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
