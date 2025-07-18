part of 'api_configuration_bloc.dart';

@immutable
sealed class ApiConfigurationEvent {}

class ApiBaseUrlConfigure extends  ApiConfigurationEvent{}

class ApiBaseUrlInitialized extends ApiConfigurationEvent {}

class ApiBsaeUrlChanged extends ApiConfigurationEvent {
  final String? baseUrl;

  ApiBsaeUrlChanged({required this.baseUrl});
}

class ApiBaseUrlUpdated extends ApiConfigurationEvent {}