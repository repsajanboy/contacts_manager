part of 'edit_contact_bloc.dart';

class EditContactState extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? profilePicture;
  final File? updateProfilePicture;
  final DateTime? dateCreated;

  const EditContactState({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.profilePicture,
    this.updateProfilePicture,
    this.dateCreated,
  });

  EditContactState copyWith({
    int? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    File? updateProfilePicture,
    DateTime? dateCreated,
  }) {
    return EditContactState(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      updateProfilePicture: updateProfilePicture ?? this.updateProfilePicture,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phoneNumber,
    profilePicture,
    updateProfilePicture,
    dateCreated,
  ];
}

