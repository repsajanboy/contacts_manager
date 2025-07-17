part of 'edit_contact_bloc.dart';

@immutable
sealed class EditContactEvent {}

class ContactDeleted extends EditContactEvent {
  final int? id;

  ContactDeleted({required this.id});
}