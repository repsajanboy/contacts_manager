part of 'add_contact_bloc.dart';


class AddContactState extends Equatable {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final File? profilePicture;
  final DateTime? dateCreated;

  const AddContactState({
    this.name,
    this.email,
    this.phoneNumber,
    this.profilePicture,
    this.dateCreated,
  });

  AddContactState copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    File? profilePicture,
    DateTime? dateCreated,
  }) {
    return AddContactState(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    phoneNumber,
    profilePicture,
    dateCreated,
  ];
}
