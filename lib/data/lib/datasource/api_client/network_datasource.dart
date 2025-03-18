import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import '../../models/app_multipart.dart';
import 'network_datasource_type.dart';

enum RequestMethod { get, post, patch, delete, put }

class NetworkDatasource implements NetworkDatasourceType {
  // Singleton pattern using a static instance
  static final NetworkDatasource _instance = NetworkDatasource._internal();

  factory NetworkDatasource() => _instance;
  NetworkDatasource._internal();

  @override
  Future<http.Response> apiRequest({
    required String url,
    required RequestMethod method,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameter,
    Map<String, String>? headers,
    required String apiPath,
  }) async {
    final Uri uri = Uri.parse(generateUrl(url: url, path: apiPath, params: queryParameter));
    final bool isConnected = await checkInternetConnection();

    if (!isConnected) {
      return _createErrorResponse(7000, "No Internet Connection");
    }

    try {
      http.Response response;
      switch (method) {
        case RequestMethod.get:
          response = await http.get(uri, headers: headers);
          break;
        case RequestMethod.post:
          response = await http.post(uri, body: jsonEncode(body), headers: headers);
          break;
        case RequestMethod.delete:
          response = await http.delete(uri, headers: headers);
          break;
        case RequestMethod.put:
          response = await http.put(uri, headers: headers, body: jsonEncode(body));
          break;
        default:
          response = await http.get(uri, headers: headers);
      }
      return response;
    } catch (e) {
      return _createErrorResponse(505, e.toString());
    }
  }

  @override
  Future<http.Response> multipartRequest({
    required String url,
    required AppMultiPartRequest multiPart,
    Map<String, String>? headers,
    String? method,
    required String apiPath,
  }) async {
    return await _handleMultipartRequest(url, multiPart, headers, "POST", apiPath);
  }

  @override
  Future<http.Response> putMultipartRequest({
    required String url,
    required AppMultiPartRequest multiPart,
    Map<String, String>? headers,
    String? method,
    required String apiPath,
  }) async {
    return await _handleMultipartRequest(url, multiPart, headers, "PUT", apiPath);
  }

  Future<http.Response> _handleMultipartRequest(
      String url,
      AppMultiPartRequest multiPart,      Map<String, String>? headers,

      String method,
      String apiPath,
      ) async {
    final Uri uri = Uri.parse(generateUrl(url: url, path: apiPath));
    final bool isConnected = await checkInternetConnection();

    if (!isConnected) {
      return _createErrorResponse(7000, "No Internet Connection");
    }

    try {
      http.MultipartRequest request = http.MultipartRequest(method, uri)
        ..fields.addAll(multiPart.fields ?? {})
        ..files.addAll(multiPart.files ?? [])
        ..headers.addAll(headers ?? {});

      http.StreamedResponse streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      return _createErrorResponse(505, e.toString());
    }
  }

  /// Utility function for error responses
  http.Response _createErrorResponse(int statusCode, String error) {
    return http.Response(jsonEncode({"error": error}), statusCode);
  }
}

/// **Improved Internet Connectivity Check**
Future<bool> checkInternetConnection() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) return false;

  // Perform a real internet check by pinging Google
  try {
    final response = await http.get(Uri.parse("https://www.google.com")).timeout(Duration(seconds: 3));
    return response.statusCode == 200;
  } catch (_) {
    return false;
  }
}

/// **Optimized URL Generation**
String generateUrl({
  required String url,
  Map<String, dynamic>? params,
  String? path,
}) {
  final Uri uri = Uri.parse(url).replace(
    path: path,
    queryParameters: params?.map((key, value) => MapEntry(key, value.toString())),
  );
  return uri.toString();
}
