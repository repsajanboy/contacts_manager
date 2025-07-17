part of 'api_configuration_bloc.dart';

@immutable
sealed class ApiConfigurationState {}

final class ApiConfigurationInitial extends ApiConfigurationState {}

final class ApiBaseUrlAlreadyConfigured extends ApiConfigurationState {}

final class ApiBaseUrlNotConfigured extends ApiConfigurationState {}