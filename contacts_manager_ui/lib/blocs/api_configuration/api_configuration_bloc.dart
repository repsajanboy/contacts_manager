import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'api_configuration_event.dart';
part 'api_configuration_state.dart';

class ApiConfigurationBloc extends Bloc<ApiConfigurationEvent, ApiConfigurationState> {
  ApiConfigurationBloc() : super(ApiConfigurationInitial()) {
    on<ApiBaseUrlConfigure>(_checkConfiguration);
    on<ApiBaseUrlInitialized>(_initializedBasedUarl);
    on<ApiBsaeUrlChanged>((event, emit) => emit(state.copyWith(apiBaseUrl: event.baseUrl)),);
    on<ApiBaseUrlUpdated>(_updateBaseUrl);
  }

  Future<void> _initializedBasedUarl(
    ApiBaseUrlInitialized event,
    Emitter<ApiConfigurationState> emit
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString('baseApiAddress');

    emit(state.copyWith(apiBaseUrl: baseUrl));
  }

  Future<void> _updateBaseUrl(
    ApiBaseUrlUpdated event,
    Emitter<ApiConfigurationState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('baseApiAddress', state.apiBaseUrl!);
  }

  Future<void> _checkConfiguration(
    ApiBaseUrlConfigure event,
    Emitter<ApiConfigurationState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString('baseApiAddress');

    if(baseUrl != null && baseUrl.isNotEmpty) {
      emit(state.copyWith(apiBaseUrl: baseUrl));
      emit(ApiBaseUrlAlreadyConfigured());
    } else {
      emit(ApiBaseUrlNotConfigured());
    }

  }
}
