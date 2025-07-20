import 'dart:convert';

import 'package:contacts_manager_ui/data/model/add_contact_model.dart';
import 'package:contacts_manager_ui/data/model/edit_contact_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactApi {
  Future<String?> _getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('baseApiAddress');
  }

  Future<dynamic> getAllContacts() async {
    final baseUrl = await _getBaseUrl();
    if (baseUrl == null) {
      throw Exception("Base URL not set.");
    }

    final url = Uri.parse('$baseUrl/api/contacts');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load contacts: ${response.statusCode}");
    }
  }

  Future<dynamic> getContact(int id) async {}

  Future<void> createContact(AddContactModel contact) async {
    final baseUrl = await _getBaseUrl();
    if (baseUrl == null) {
      throw Exception("Base URL not set.");
    }

    final url = Uri.parse('$baseUrl/api/contacts');
    final request = http.MultipartRequest('POST', url);
    request.fields['name'] = contact.name!;
    request.fields['email'] = contact.email!;
    request.fields['phoneNumber'] = contact.phoneNumber!;

    if (contact.profilePicture != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'profilePicture',
          contact.profilePicture!.path,
          filename: basename(
            contact.profilePicture!.path,
          ),
        ),
      );
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      print('Added contact successfully');
    } else {
      throw Exception("Failed to add contact: ${response.statusCode}");
    }
  }

  Future<dynamic> editContact(int id, EditContactModel updatedContact) async {
    final baseUrl = await _getBaseUrl();
    if (baseUrl == null) {
      throw Exception("Base URL not set.");
    }

    final url = Uri.parse('$baseUrl/api/contacts/$id');
    final request = http.MultipartRequest('PUT', url);
    request.fields['names'] = updatedContact.name!;
    request.fields['email'] = updatedContact.email!;
    request.fields['phoneNumber'] = updatedContact.phoneNumber!;
    request.fields['dateCreated'] = updatedContact.dateCreated!.toIso8601String();

    if (updatedContact.updatedProfilePicture != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'profilePicture',
          updatedContact.updatedProfilePicture!.path,
          filename: basename(
            updatedContact.updatedProfilePicture!.path,
          ),
        ),
      );
    } else {
      request.fields['profilePicture'] = updatedContact.profilePicture!;
    }

    final response = await request.send();

    if (response.statusCode == 204) {
      print('Contact updated successfully');
    } else {
      throw Exception("Failed to delete contact: ${response.statusCode}");
    }
  }

  Future<void> deleteContact(int id) async {
    final baseUrl = await _getBaseUrl();
    if (baseUrl == null) {
      throw Exception("Base URL not set.");
    }

    final url = Uri.parse('$baseUrl/api/contacts/$id');
    final response = await http.delete(url);

    if (response.statusCode == 204) {
      print('Deleted successfully');
    } else {
      throw Exception("Failed to delete contact: ${response.statusCode}");
    }
  }
}
