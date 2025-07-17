part of 'contact_list_bloc.dart';

@immutable
sealed class ContactListEvent {}

class ContactListFetched extends ContactListEvent {}
