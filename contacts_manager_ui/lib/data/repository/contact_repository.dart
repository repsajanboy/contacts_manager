import 'package:contacts_manager_ui/data/api/contact_api.dart';
import 'package:contacts_manager_ui/data/model/add_contact_model.dart';
import 'package:contacts_manager_ui/data/model/contact_model.dart';
import 'package:contacts_manager_ui/data/model/edit_contact_model.dart';

class ContactRepository {

  final ContactApi contactApi = ContactApi();
  
  Future<List<ContactModel>> getAllContacts() async {
    final result = await contactApi.getAllContacts() as List;
    return result.map((e) {
      return ContactModel.fromJson(e);
    }).toList();
  }

  Future<void> addContact(AddContactModel contact) async {
    await contactApi.createContact(contact);
  }

  Future<void> updateContact(int id, EditContactModel updatedContact) async {
    await contactApi.editContact(id, updatedContact);
  }

  Future<void> deleteContact(int id) async {
    await contactApi.deleteContact(id);
  }
}