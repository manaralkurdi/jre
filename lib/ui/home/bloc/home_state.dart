import 'package:jre_app/base/bloc/base_bloc.dart';

import '../../../model/home/proparty_model.dart' show Property;
enum HomeStatus { initial, loading, loaded, error }

class HomeState extends BaseState {
  final HomeStatus status;

  final bool isLoading;
  final List<Property> featuredProperties;
  final List<Property> recommendedProperties;
  final List<Property> filteredProperties;
  final String selectedPropertyType;
  final String? errorMessage;

  HomeState({
    required this.status,

    this.isLoading = false,
    this.featuredProperties = const [],
    this.recommendedProperties = const [],
    this.filteredProperties = const [],
    this.selectedPropertyType = 'All',
    this.errorMessage,
  });
  factory HomeState.initial() =>  HomeState(
    status: HomeStatus.initial,
    featuredProperties: [],
    recommendedProperties: [],
    filteredProperties: [],
    selectedPropertyType: 'All',
    errorMessage: null,
  );
  HomeState copyWith({
    HomeStatus? status,

    bool? isLoading,
    List<Property>? featuredProperties,
    List<Property>? recommendedProperties,
    List<Property>? filteredProperties,
    String? selectedPropertyType,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      featuredProperties: featuredProperties ?? this.featuredProperties,
      recommendedProperties: recommendedProperties ?? this.recommendedProperties,
      filteredProperties: filteredProperties ?? this.filteredProperties,
      selectedPropertyType: selectedPropertyType ?? this.selectedPropertyType,
      errorMessage: errorMessage,
    );
  }
  @override
  List<Object?> get props => [
    status,
    featuredProperties,
    recommendedProperties,
    filteredProperties,
    selectedPropertyType,
    errorMessage,
  ];
}