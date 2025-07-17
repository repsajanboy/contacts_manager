import 'package:contacts_manager_ui/routing/app_router_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiConfigurationScreen extends StatelessWidget {
  ApiConfigurationScreen({super.key});

  final TextEditingController _baseApiController = TextEditingController();

  Future<void> _saveBaseAPI(String baseApi) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('baseApiAddress', baseApi);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your base api address:',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _baseApiController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'https://localhost:5001',
                hintStyle: TextStyle(
                  color: Colors.black54,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black
                  )
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )
                )
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff023563),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  _saveBaseAPI(_baseApiController.text);
                  Navigator.pushNamed(context, RouteNames.contactListScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18.0
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
