part of 'add_contact_bloc.dart';

@immutable
sealed class AddContactEvent {}

class AddContactNameChanged extends AddContactEvent {
  final String? name;
  AddContactNameChanged({required this.name});
}

class AddContactEmailChanged extends AddContactEvent {
  final String? email;

  AddContactEmailChanged({required this.email});
}

class AddContactPhoneNumberChanged extends AddContactEvent {
  final String? phoneNumber;

  AddContactPhoneNumberChanged({required this.phoneNumber});
}

class AddContactProfilePictureChanged extends AddContactEvent {
  final String? profilePicture;

  AddContactProfilePictureChanged({required this.profilePicture});
}

class AddContactSubmitted extends AddContactEvent {}