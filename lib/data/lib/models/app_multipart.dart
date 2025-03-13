import 'package:http/http.dart';

class AppMultiPartRequest {
  final dynamic fields;
  final List<MultipartFile>? files;

  AppMultiPartRequest({this.fields, this.files});
}
