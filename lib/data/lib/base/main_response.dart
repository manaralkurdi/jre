class AppBaseResponse {
  final bool success;
  final dynamic response;
  final String responseMessage;
  final List<String> errorCodes;
  final bool noInternet;
  final bool isDataException;
  final bool isException;

  AppBaseResponse({
    required this.success,
    required this.response,
    this.responseMessage = '',
    this.errorCodes = const [],
    this.noInternet = false,
    this.isDataException = false,
    this.isException = false,
  });
}