import 'package:dartz/dartz.dart';

import '../../../data/lib/base/api_path.dart';
import '../../../data/lib/base/app_config.dart';
import '../../../data/lib/base/error_response.dart';
import '../../../data/lib/base/main_response.dart';
import '../../model/home/Real_estate_ourReco_model.dart';
import '../../model/home/filter_request.dart';
import '../../model/home/proparty_model.dart';
import 'random_realEstate.dart';

abstract class RealEstateRepositoryType {
  final AppConfig appConfig;

  RealEstateRepositoryType({required this.appConfig});

  Future<Either<ErrorResponse, RealEstateResponse>> getRandomProperties();
  Future<Either<ErrorResponse, RealEstateResponse>> getFeaturedList();

  Future<Either<ErrorResponse, PropertyCategoryResponse>> getCategoryDetails({int? id,});
  Future<Either<ErrorResponse, PropertyCategoryResponse>> getDetails({int? id,});
  Future<Either<ErrorResponse, PropertyCategoryResponse>> getFilter({RealEstateFilterRequest request});
}

class RealEstateRepository extends RealEstateRepositoryType {
  RealEstateRepository({required super.appConfig});

  @override
  Future<Either<ErrorResponse, RealEstateResponse>>
  getRandomProperties() async {
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';
    AppBaseResponse response = await callPostApi(
      url: await appConfig.baseUrl,
      headers: headers,
      body: {'type': 'real_estates'}, // Sending type parameter
      apiPath: ApiPaths.ourRecomendation,
    );

    if (response.success) {
      return Right(RealEstateResponse.fromJson(response.response));
    } else {
      return Left(
        response.noInternet
            ? NoConnectionErrorResponse()
            : response.isDataException
            ? DataExceptionResponse(
              response.responseMessage,
              response.errorCodes,
            )
            : response.isException
            ? KnownException(response.responseMessage, const [])
            : UnknownErrorResponse(),
      );
    }
  }

  @override
  Future<Either<ErrorResponse, PropertyCategoryResponse>> getCategoryDetails({
    int? id,
  }) async {
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';
    AppBaseResponse response = await callPostApi(
      url: await appConfig.baseUrl,
      headers: headers,
      body: {'type': 'real_estates', 'property_type': id},
      // Sending type parameter
      apiPath: ApiPaths.category,
    );

    if (response.success) {
      return Right(PropertyCategoryResponse.fromJson(response.response));
    } else {
      return Left(
        response.noInternet
            ? NoConnectionErrorResponse()
            : response.isDataException
            ? DataExceptionResponse(
              response.responseMessage,
              response.errorCodes,
            )
            : response.isException
            ? KnownException(response.responseMessage, const [])
            : UnknownErrorResponse(),
      );
    }
  }

  @override
  Future<Either<ErrorResponse, RealEstateResponse>> getFeaturedList() async {
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';
    AppBaseResponse response = await callPostApi(
      url: await appConfig.baseUrl,
      headers: headers,
      body: {'type': 'real_estates'}, // Sending type parameter
      apiPath: ApiPaths.featured,
    );

    if (response.success) {
      return Right(RealEstateResponse.fromJson(response.response));
    } else {
      return Left(
        response.noInternet
            ? NoConnectionErrorResponse()
            : response.isDataException
            ? DataExceptionResponse(
          response.responseMessage,
          response.errorCodes,
        )
            : response.isException
            ? KnownException(response.responseMessage, const [])
            : UnknownErrorResponse(),
      );
    }
  }

  @override
  Future<Either<ErrorResponse, PropertyCategoryResponse>> getDetails({
    int? id,
  }) async {
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';
    AppBaseResponse response = await callPostApi(
      url: await appConfig.baseUrl,
      headers: headers,
      body: {'type': 'real_estates', 'id': id},
      // Sending type parameter
      apiPath: ApiPaths.details,
    );

    if (response.success) {
      return Right(PropertyCategoryResponse.fromJson(response.response));
    } else {
      return Left(
        response.noInternet
            ? NoConnectionErrorResponse()
            : response.isDataException
            ? DataExceptionResponse(
          response.responseMessage,
          response.errorCodes,
        )
            : response.isException
            ? KnownException(response.responseMessage, const [])
            : UnknownErrorResponse(),
      );
    }
  }

  @override
  Future<Either<ErrorResponse, PropertyCategoryResponse>> getFilter({
    RealEstateFilterRequest ? request
  }) async {
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';
    AppBaseResponse response = await callPostApi(
      url: await appConfig.baseUrl,
      headers: headers,
      body: request!.toJson(),
      // Sending type parameter
      apiPath: ApiPaths.filter,
    );

    if (response.success) {
      return Right(PropertyCategoryResponse.fromJson(response.response));
    } else {
      return Left(
        response.noInternet
            ? NoConnectionErrorResponse()
            : response.isDataException
            ? DataExceptionResponse(
          response.responseMessage,
          response.errorCodes,
        )
            : response.isException
            ? KnownException(response.responseMessage, const [])
            : UnknownErrorResponse(),
      );
    }
  }
}
