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
  }

  final ContactRepository contactRepository = ContactRepository();

  Future<void> _addContactSubmitted(
    AddContactSubmitted event,
    Emitter<AddContactState> emit,
  ) async {
    try {
      Map<String, dynamic> data = {
        "name": state.name,
        "email": state.email,
        "phoneNumber": state.phoneNumber,
        "profilePicture": "",
        "dateCreated": DateTime.now().toIso8601String(),
      };
      await contactRepository.addContact(data);
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
