import 'dart:io';

class EditContactModel {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? profilePicture;
  File? updatedProfilePicture;
  DateTime? dateCreated;

  EditContactModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.profilePicture,
    this.updatedProfilePicture,
    this.dateCreated
  });
}
