import 'package:contacts_manager_ui/data/api/contact_api.dart';
import 'package:contacts_manager_ui/data/model/contact_model.dart';

class ContactRepository {
  
  final ContactApi contactApi = ContactApi();
  
  Future<List<ContactModel>> getAllContacts() async {
    final result = await contactApi.getAllContacts() as List;
    return result.map((e) {
      return ContactModel.fromJson(e);
    }).toList();
  }
}