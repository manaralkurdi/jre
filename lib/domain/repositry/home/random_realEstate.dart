import 'dart:convert';

import '../../../data/lib/base/main_response.dart';
import '../../../data/lib/datasource/api_client/network_datasource.dart';
import 'repositry_random.dart';

extension ApiCallExtension on RealEstateRepositoryType {
  Future<AppBaseResponse> callPostApi({
    required String url,
    required Map<String, String> headers,
    required Map<String, dynamic> body,
    required String apiPath,
  }) async {
    try {
      final networkDatasource = NetworkDatasource();
      final response = await networkDatasource.apiRequest(
        url: url,
        method: RequestMethod.post,
        body: body,
        headers: headers,
        apiPath: apiPath,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return AppBaseResponse(
          success: true,
          response: jsonResponse,
        );
      } else {
        String message = '';
        List<String> errorCodes = [];

        try {
          final jsonResponse = jsonDecode(response.body);
          message = jsonResponse['message'] ?? 'Error occurred';
          // Handle error codes if available in your API response
          errorCodes = jsonResponse['error_codes'] != null
              ? List<String>.from(jsonResponse['error_codes'])
              : [];
        } catch (e) {
          message = 'Failed to parse error response';
        }

        return AppBaseResponse(
          success: false,
          response: null,
          responseMessage: message,
          errorCodes: errorCodes,
          isDataException: true,
        );
      }
    } catch (e) {
      if (e.toString().contains('SocketException') ||
          e.toString().contains('Connection refused')) {
        return AppBaseResponse(
          success: false,
          response: null,
          responseMessage: 'No internet connection',
          noInternet: true,
        );
      } else {
        return AppBaseResponse(
          success: false,
          response: null,
          responseMessage: e.toString(),
          isException: true,
        );
      }
    }
  }
}