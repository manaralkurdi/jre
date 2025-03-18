import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:jre_app/base/bloc/base_bloc.dart';

import '../../../data/lib/base/error_response.dart';
import '../../../domain/model/home/details.dart' show DetailsProperty, PropertyData;

import '../../../domain/model/home/proparty_model.dart';
import '../../../domain/repositry/home/repositry_random.dart';
import 'category_event.dart';
import 'category_state.dart';
class CategoryBloc extends BaseBloc<CategoryEvent, CategoryState> {
  final RealEstateRepositoryType  repository ;

  CategoryBloc(this.repository) : super(initialState: CategoryState.initial()) {
    on<CategoryDetailsLoaded>(_onFetchCategoryList);

    // on<FetchUserLocation>(_onFetchUserLocation); on<SearchEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }



  Future<void> _onFetchCategoryList(CategoryDetailsLoaded event,
      Emitter<CategoryState> emit) async {
    // Log the current state and the event ID
    print('Current state before API call: ${state.status}, ID: ${event.id}');

    emit.call(state.copyWith(status: CategoryStatus.loadingCategory, isLoading: true));

    // Log that we're making the API call
    print('Making API call for category ID: ${event.id}');

    final Either<ErrorResponse, PropertyCategoryResponse> result =
    await repository.getCategoryDetails(id: event.id);

    result.fold((error) {
      // Log error details
      print('Error response: ${error.message}');
      emit.call(state.copyWith(
          status: CategoryStatus.error, errorMessage: error.message, isLoading: false));
    }, (data) {
      // Log success details
      print('Success response with ${data.data?.length ?? 0} items');
      emit.call(state.copyWith(
          status: CategoryStatus.apiSuccessCategoryDeatils,
          categoryProperties: data.data,
          isLoading: false));
    });
  }
  // facility: [
  // FacilityModel(title: "WiFi", img: "assets/images/images/wifi.png"),
  // FacilityModel(title: "Pool", img: "assets/images/images/pool.png"),
  // FacilityModel(title: "Gym", img: "assets/images/images/gym.png"),
  // FacilityModel(title: "Parking", img: "assets/images/images/parking.png"),
  // FacilityModel(title: "AC", img: "assets/images/images/ac.png"),
  // FacilityModel(title: "Kitchen", img: "assets/images/images/kitchen.png"),
  // ],

}

