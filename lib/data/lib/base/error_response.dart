abstract class ErrorResponse {
  final String message;
  final List<String> errorCodes;

  ErrorResponse(this.message, this.errorCodes);
}

class NoConnectionErrorResponse extends ErrorResponse {
  NoConnectionErrorResponse() : super('No internet connection', const []);
}

class DataExceptionResponse extends ErrorResponse {
  DataExceptionResponse(String message, List<String> errorCodes)
      : super(message, errorCodes);
}

class KnownException extends ErrorResponse {
  KnownException(String message, List<String> errorCodes)
      : super(message, errorCodes);
}

class UnknownErrorResponse extends ErrorResponse {
  UnknownErrorResponse() : super('Unknown error occurred', const []);
}
