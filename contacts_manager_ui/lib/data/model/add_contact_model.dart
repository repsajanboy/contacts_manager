import 'dart:io';

class AddContactModel {
  String? name;
  String? email;
  String? phoneNumber;
  File? profilePicture;

  AddContactModel({
    this.name,
    this.email,
    this.phoneNumber,
    this.profilePicture,
  });
}
