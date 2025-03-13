import 'package:jre_app/base/bloc/base_bloc.dart';

import '../../../domain/model/home/Real_estate_ourReco_model.dart';
import '../../../domain/model/home/details.dart';
import '../../../domain/model/home/proparty_model.dart';

enum HomeStatus { initial, loading, loaded, error,allDataLoaded,
  apiSuccessFeatured,SearchSuccsess,apiSuccessRandom,apiSuccessDetails,apiSuccessCategoryDeatils }

class HomeState extends BaseState {
  final HomeStatus status;

  final bool isLoading;
  final List<Property> featuredProperties;
  final List<Property> recommendedProperties;
  final List<PropertyDataCategory> filteredProperties;
  final List<PropertyDataCategory> categoryProperties;
  final DetailsProperty detailsProperties;
  final String selectedPropertyType;
  final String? errorMessage;

  HomeState({
    required this.status,
    this.isLoading = false,
    this.featuredProperties = const [],
    this.categoryProperties = const [],
    this.recommendedProperties = const [],
    this.filteredProperties = const [],
    required this.detailsProperties,
    this.selectedPropertyType = 'All',
    this.errorMessage,
  });
  factory HomeState.initial() =>  HomeState(
    status: HomeStatus.initial,
    featuredProperties: [],
    recommendedProperties: [],
    filteredProperties: [],
    selectedPropertyType: 'All',categoryProperties: [],detailsProperties:DetailsProperty(),
    errorMessage: null,
  );
  HomeState copyWith({
    HomeStatus? status,

    bool? isLoading,
    List<Property>? featuredProperties,
    List<Property>? recommendedProperties,
    List<PropertyDataCategory>? filteredProperties,
    List<PropertyDataCategory>? categoryProperties,
    DetailsProperty? detailsProperties,
    String? selectedPropertyType,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      featuredProperties: featuredProperties ?? this.featuredProperties,
      categoryProperties: categoryProperties ?? this.categoryProperties,
      recommendedProperties: recommendedProperties ?? this.recommendedProperties,
      filteredProperties: filteredProperties ?? this.filteredProperties,
      selectedPropertyType: selectedPropertyType ?? this.selectedPropertyType,
      detailsProperties: detailsProperties ?? this.detailsProperties,
      errorMessage: errorMessage,
    );
  }
  @override
  List<Object?> get props => [
    status,
    featuredProperties,
    recommendedProperties,
    filteredProperties,categoryProperties,
    selectedPropertyType,
    errorMessage,detailsProperties
  ];
}