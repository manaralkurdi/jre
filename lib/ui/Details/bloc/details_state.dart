


import '../../../base/bloc/base_bloc.dart';
import '../../../domain/model/home/details.dart';

enum DetailsStatus { initial, loading, loaded, error,allDataLoaded,
  apiSuccessFeatured,SearchSuccsess,apiSuccessRandom,apiSuccessDetails,apiSuccessCategoryDeatils }

class DetailsState extends BaseState {
  final DetailsStatus status;

  final bool isLoading;
  final DetailsProperty detailsProperties;
  final String selectedPropertyType;
  final String? errorMessage;

  DetailsState({
    required this.status,
    this.isLoading = false,
    required this.detailsProperties,
    this.selectedPropertyType = 'All',
    this.errorMessage,
  });
  factory DetailsState.initial() =>  DetailsState(
    status: DetailsStatus.initial,
    selectedPropertyType: 'All',detailsProperties:DetailsProperty(),
    errorMessage: null,
  );
  DetailsState copyWith({
    DetailsStatus? status,

    bool? isLoading,

    DetailsProperty? detailsProperties,
    String? selectedPropertyType,
    String? errorMessage,
  }) {
    return DetailsState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      selectedPropertyType: selectedPropertyType ?? this.selectedPropertyType,
      detailsProperties: detailsProperties ?? this.detailsProperties,
      errorMessage: errorMessage,
    );
  }
  @override
  List<Object?> get props => [
    status,
    selectedPropertyType,
    errorMessage,detailsProperties
  ];
}