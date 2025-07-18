import 'package:contacts_manager_ui/data/model/contact_model.dart';
import 'package:contacts_manager_ui/data/repository/contact_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_contact_event.dart';
part 'edit_contact_state.dart';

class EditContactBloc extends Bloc<EditContactEvent, EditContactState> {
  EditContactBloc() : super(EditContactState()) {
    on<ContactDeleted>(_deleteContact);
    on<EditContactNameChanged>(
      (event, emit) => emit(state.copyWith(name: event.name)),
    );
    on<EditContactEmailChanged>(
      (event, emit) => emit(state.copyWith(email: event.email)),
    );
    on<EditContactPhoneNumberChanged>(
      (event, emit) => emit(state.copyWith(phoneNumber: event.phoneNumber)),
    );
    on<EditContactSaved>(_saveEditContact);
    on<EditContactInitialized>(_initializedContactValues);
  }

  final ContactRepository contactRepository = ContactRepository();

  Future<void> _saveEditContact(
    EditContactSaved event,
    Emitter<EditContactState> emit,
  ) async {
    try {
      Map<String, dynamic> data = {
        "id": event.id,
        "name": state.name,
        "email": state.email,
        "phoneNumber": state.phoneNumber,
        "profilePicture": state.profilePicture,
        "dateCreated": state.dateCreated!.toIso8601String()
      };

      await contactRepository.updateContact(event.id!, data);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> _initializedContactValues(
    EditContactInitialized event,
    Emitter<EditContactState> emit,
  ) async {
    try {
      emit(state.copyWith(
        id: event.contact.id,
        name: event.contact.name,
        email: event.contact.email,
        phoneNumber: event.contact.phoneNumber,
        profilePicture: event.contact.profilePicture,
        dateCreated: event.contact.dateCreated,
      ));
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> _deleteContact(
    ContactDeleted event,
    Emitter<EditContactState> emit,
  ) async {
    try {
      await contactRepository.deleteContact(event.id!);
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
