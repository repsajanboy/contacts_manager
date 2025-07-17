part of 'api_configuration_bloc.dart';

@immutable
sealed class ApiConfigurationEvent {}

class ApiBaseUrlConfigure extends  ApiConfigurationEvent{}