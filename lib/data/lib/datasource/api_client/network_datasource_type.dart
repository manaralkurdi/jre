import 'package:http/http.dart' as http;

import '../../models/app_multipart.dart';
import 'network_datasource.dart';

abstract class NetworkDatasourceType {
  Future<http.Response> apiRequest({
    required String url,
    required RequestMethod method,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameter,
    Map<String, String>? headers,
    required String apiPath,
  });

  Future<http.Response> multipartRequest({
    required String url,
    Map<String, String>? headers,
    required AppMultiPartRequest multiPart,
    required String apiPath,
  });

  Future<http.Response> putMultipartRequest({
    required String url,
    Map<String, String>? headers,
    required AppMultiPartRequest multiPart,
    required String apiPath,
  });
}
