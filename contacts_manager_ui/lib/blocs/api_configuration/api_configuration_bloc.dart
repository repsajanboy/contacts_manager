import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'api_configuration_event.dart';
part 'api_configuration_state.dart';

class ApiConfigurationBloc extends Bloc<ApiConfigurationEvent, ApiConfigurationState> {
  ApiConfigurationBloc() : super(ApiConfigurationInitial()) {
    on<ApiBaseUrlConfigure>(_checkConfiguration);
  }

  Future<void> _checkConfiguration(
    ApiBaseUrlConfigure event,
    Emitter<ApiConfigurationState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString('baseApiAddress');

    if(baseUrl != null && baseUrl.isNotEmpty) {
      emit(ApiBaseUrlAlreadyConfigured());
    } else {
      emit(ApiBaseUrlNotConfigured());
    }

  }
}
