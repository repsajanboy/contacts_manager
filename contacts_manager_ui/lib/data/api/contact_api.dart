import 'dart:convert';

import 'package:http/http.dart' as http;
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

  Future<void> createContact(Map<String, dynamic> data) async {
    final baseUrl = await _getBaseUrl();
    if (baseUrl == null) {
      throw Exception("Base URL not set.");
    }

    final url = Uri.parse('$baseUrl/api/contacts');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      print('Added contact successfully');
    } else {
      throw Exception("Failed to add contact: ${response.statusCode}");
    }
  }

  Future<dynamic> editContact(int id, Map<String, dynamic> data) async {
    final baseUrl = await _getBaseUrl();
    if (baseUrl == null) {
      throw Exception("Base URL not set.");
    }

    final url = Uri.parse('$baseUrl/api/contacts/$id');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if(response.statusCode == 204) {
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
