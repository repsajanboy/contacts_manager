import 'package:contacts_manager_ui/blocs/bloc_barrel.dart';
import 'package:contacts_manager_ui/routing/app_router_names.dart';
import 'package:contacts_manager_ui/utils/global_sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: BlocConsumer<ApiConfigurationBloc, ApiConfigurationState>(
        listener: (context, state) {
          if (state is ApiBaseUrlAlreadyConfigured) {
            Navigator.pushReplacementNamed(
                context, RouteNames.contactListScreen);
          }
        },
        builder: (context, state) {
          if (state is  ApiBaseUrlNotConfigured) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter your base api address:',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: _baseApiController,
                    cursorColor: Colors.black,
                    style: TextStyle(fontFamily: 'WorkSans'),
                    decoration: InputDecoration(
                        hintText: 'https://localhost:5001',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        ))),
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
                        final baseApi = _baseApiController.text.trim();

                        if (baseApi.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter api base address!'),
                            ),
                          );
                        } else {
                          _saveBaseAPI(baseApi);
                          GlobalSharedpref.init();
                          BlocProvider.of<ContactListBloc>(context)
                              .add(ContactListFetched());
                          Navigator.pushNamed(
                              context, RouteNames.contactListScreen);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
