part of 'edit_contact_bloc.dart';

@immutable
sealed class EditContactEvent {}

class ContactDeleted extends EditContactEvent {
  final int? id;

  ContactDeleted({required this.id});
}

class EditContactNameChanged extends EditContactEvent {
  final String? name;

  EditContactNameChanged({required this.name});
}

class EditContactEmailChanged extends EditContactEvent {
  final String? email;

  EditContactEmailChanged({required this.email});
}

class EditContactPhoneNumberChanged extends EditContactEvent {
  final String? phoneNumber;

  EditContactPhoneNumberChanged({required this.phoneNumber});
}

class EditContactProfilePictureChanged extends EditContactEvent {
  final File? updateProfilePicture;

  EditContactProfilePictureChanged({required this.updateProfilePicture});
}

class EditContactSaved extends EditContactEvent {
  final int? id;

  EditContactSaved({required this.id});
}

class EditContactInitialized extends EditContactEvent {
  final ContactModel contact;

  EditContactInitialized({required this.contact});
}