part of 'api_configuration_bloc.dart';

class ApiConfigurationState extends Equatable {
  final String? apiBaseUrl;

  const ApiConfigurationState({
    this.apiBaseUrl,
  });

  ApiConfigurationState copyWith({
    String? apiBaseUrl,
  }) {
    return ApiConfigurationState(
      apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
    );
  }

  @override
  List<Object?> get props => [
        apiBaseUrl,
      ];
}

class ApiConfigurationInitial extends ApiConfigurationState {}

class ApiBaseUrlAlreadyConfigured extends ApiConfigurationState {}

class ApiBaseUrlNotConfigured extends ApiConfigurationState {}
