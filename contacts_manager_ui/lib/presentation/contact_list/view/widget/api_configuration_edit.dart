import 'package:contacts_manager_ui/blocs/bloc_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget apiConfigurationEdit(BuildContext context) {
  return Padding(
    padding: MediaQuery.of(context).viewInsets,
    child: Container(
      height: MediaQuery.of(context).size.height * .5,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Update API base url:',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            BlocBuilder<ApiConfigurationBloc, ApiConfigurationState>(
              builder: (context, state) {
                if (state.apiBaseUrl == null) {
                  return CircularProgressIndicator();
                }
                return TextFormField(
                  initialValue: state.apiBaseUrl,
                  style: TextStyle(fontFamily: 'WorkSans', color: Colors.black),
                  decoration: InputDecoration(hintText: 'Enter api base url'),
                  onChanged: (value) {
                    context
                        .read<ApiConfigurationBloc>()
                        .add(ApiBsaeUrlChanged(baseUrl: value));
                  },
                );
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: BlocBuilder<ApiConfigurationBloc, ApiConfigurationState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      context
                          .read<ApiConfigurationBloc>()
                          .add(ApiBaseUrlUpdated());
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff023563),
                      foregroundColor: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    ),
  );
}
