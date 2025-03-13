import '../datasource/api_client/network_datasource.dart';
import '../datasource/api_client/network_datasource_type.dart';
import '../datasource/shared_preference/local_datasource.dart' show LocalDatasource;
import '../datasource/shared_preference/local_datasource_type.dart';

mixin DatasourceModule {
  /// API/REST Client
  NetworkDatasourceType get apiClient => NetworkDatasource();

  /// Local Storage
  LocalDatasourceType get sharesPreference => LocalDatasource();
}