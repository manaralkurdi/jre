import 'package:jre_app/base/bloc/base_bloc.dart';

import '../../../domain/model/home/Real_estate_ourReco_model.dart';
import '../../../domain/model/home/details.dart';
import '../../../domain/model/home/proparty_model.dart';

enum SearchStatus { initial, loading, loaded, error,allDataLoaded,
  apiSuccessFeatured,SearchSuccsess,apiSuccessRandom,apiSuccessDetails,apiSuccessCategoryDeatils }

class SearchState extends BaseState {
  final SearchStatus status;

  final bool isLoading;
  final List<Property> featuredProperties;
  final List<Property> recommendedProperties;
  final List<PropertyDataCategory> filteredProperties;
  final List<PropertyDataCategory> categoryProperties;
  final DetailsProperty detailsProperties;
  final String selectedPropertyType;
  final String? errorMessage;

  SearchState({
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
  factory SearchState.initial() =>  SearchState(
    status: SearchStatus.initial,
    featuredProperties: [],
    recommendedProperties: [],
    filteredProperties: [],
    selectedPropertyType: 'All',categoryProperties: [],detailsProperties:DetailsProperty(),
    errorMessage: null,
  );
  SearchState copyWith({
    SearchStatus? status,

    bool? isLoading,
    List<Property>? featuredProperties,
    List<Property>? recommendedProperties,
    List<PropertyDataCategory>? filteredProperties,
    List<PropertyDataCategory>? categoryProperties,
    DetailsProperty? detailsProperties,
    String? selectedPropertyType,
    String? errorMessage,
  }) {
    return SearchState(
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