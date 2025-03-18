


import '../../../base/bloc/base_bloc.dart';
import '../../../domain/model/home/details.dart';
import '../../../domain/model/home/proparty_model.dart';

enum CategoryStatus { initial, loading, loaded, error,allDataLoaded,loadingCategory,
  apiSuccessFeatured,SearchSuccsess,apiSuccessRandom,apiSuccessDetails,apiSuccessCategoryDeatils }

class CategoryState extends BaseState {
  final CategoryStatus status;

  final bool isLoading;
  final String selectedPropertyType;
  final String? errorMessage;
  final List<PropertyDataCategory> ? categoryProperties;

  CategoryState({
    required this.status,
    this.categoryProperties,
    this.isLoading = false,
    this.selectedPropertyType = 'All',
    this.errorMessage,
  });
  factory CategoryState.initial() =>  CategoryState(
    status: CategoryStatus.initial,
    selectedPropertyType: 'All',categoryProperties:[],
    errorMessage: null,
  );
  CategoryState copyWith({
    CategoryStatus? status,

    bool? isLoading,

    String? selectedPropertyType,
    String? errorMessage,
    List<PropertyDataCategory> ? categoryProperties,
  }) {
    return CategoryState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      selectedPropertyType: selectedPropertyType ?? this.selectedPropertyType,
      categoryProperties: categoryProperties ?? this.categoryProperties,
      errorMessage: errorMessage,
    );
  }
  @override
  List<Object?> get props => [
    status,
    selectedPropertyType,
    errorMessage,categoryProperties
  ];
}