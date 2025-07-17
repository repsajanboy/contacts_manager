import 'package:contacts_manager_ui/data/repository/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_contact_event.dart';
part 'edit_contact_state.dart';

class EditContactBloc extends Bloc<EditContactEvent, EditContactState> {
  EditContactBloc() : super(EditContactInitial()) {
    on<ContactDeleted>(_deleteContact);
  }

  final ContactRepository contactRepository = ContactRepository();

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
