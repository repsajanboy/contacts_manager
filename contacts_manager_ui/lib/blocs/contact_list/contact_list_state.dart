part of 'contact_list_bloc.dart';

class ContactListState extends Equatable {
  final List<ContactModel> contacts;

  const ContactListState({
    this.contacts = const <ContactModel>[],
  });

  ContactListState copyWith({
    List<ContactModel>? contacts,
  }) {
    return ContactListState(
      contacts: contacts ?? this.contacts,
    );
  }

  @override
  List<Object?> get props => [
        contacts,
      ];
}
