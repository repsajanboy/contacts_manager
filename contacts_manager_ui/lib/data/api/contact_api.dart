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

  Future<dynamic> createContact(Map<String, dynamic> data) async {
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

    if(response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to add contact: ${response.statusCode}");
    }
  }

  Future<dynamic> editContact() async {}

  Future<dynamic> deleteContact(int id) async {}
}
