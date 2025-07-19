import 'dart:io';

import 'package:contacts_manager_ui/data/model/add_contact_model.dart';
import 'package:contacts_manager_ui/data/repository/contact_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_contact_event.dart';
part 'add_contact_state.dart';

class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  AddContactBloc() : super(AddContactState()) {
    on<AddContactSubmitted>(_addContactSubmitted);
    on<AddContactNameChanged>(
      (event, emit) => emit(state.copyWith(name: event.name)),
    );
    on<AddContactEmailChanged>(
      (event, emit) => emit(state.copyWith(email: event.email)),
    );
    on<AddContactPhoneNumberChanged>(
      (event, emit) => emit(state.copyWith(phoneNumber: event.phoneNumber)),
    );
    on<AddContactProfilePictureChanged>(
      (event, emit) =>
          emit(state.copyWith(profilePicture: event.profilePicture)),
    );
  }

  final ContactRepository contactRepository = ContactRepository();

  Future<void> _addContactSubmitted(
    AddContactSubmitted event,
    Emitter<AddContactState> emit,
  ) async {

    final contact = AddContactModel(
      name: state.name,
      email: state.email,
      phoneNumber: state.phoneNumber,
      profilePicture: state.profilePicture,
    );
    try {

      await contactRepository.addContact(contact);
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
