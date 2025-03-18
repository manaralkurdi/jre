import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:jre_app/base/bloc/base_bloc.dart';

import '../../../data/lib/base/error_response.dart';
import '../../../domain/model/home/Real_estate_ourReco_model.dart';
import '../../../domain/model/home/details.dart' show DetailsProperty;
import '../../../domain/model/home/proparty_model.dart';
import '../../../domain/repositry/home/repositry_random.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final RealEstateRepositoryType  repository ;

  HomeBloc(this.repository) : super(initialState: HomeState.initial()) {
    on<LoadHomeDataEvent>(_loadHomeDataEvent);
    on<FeaturedLoaded>(_onFetchFeaturedList);
    on<CategoryDetailsLoaded>(_onFetchCategoryList);
    on<RealEstateRandomLoaded>(_onFetchRandomProperties);
    // on<FetchUserLocation>(_onFetchUserLocation); on<HomeEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }

  Future<void> _loadHomeDataEvent(LoadHomeDataEvent event,
      Emitter<HomeState> emit) async {
    emit.call(state.copyWith(status: HomeStatus.loading,));

    add(FeaturedLoaded());
    add(RealEstateRandomLoaded());
  }

  Future<void> _onFetchRandomProperties(RealEstateRandomLoaded event,
      Emitter<HomeState> emit) async {
    emit.call(state.copyWith(status: HomeStatus.loading,));
    final Either<ErrorResponse, RealEstateResponse> result =
    await repository.getRandomProperties();
    result.fold((error) {
      emit.call(state.copyWith(
          status: HomeStatus.error, errorMessage: error.message));
    }, (data) {
      emit.call(state.copyWith(status: HomeStatus.apiSuccessRandom,recommendedProperties: data.data));
    });
  }


  Future<void> _onFetchCategoryList(CategoryDetailsLoaded event,
      Emitter<HomeState> emit) async {
    emit.call(state.copyWith(status: HomeStatus.loadingCategory,isLoading: true));
    final Either<ErrorResponse, PropertyCategoryResponse> result =
    await repository.getCategoryDetails(id: event.id);
    result.fold((error) {
      emit.call(state.copyWith(
          status: HomeStatus.error, errorMessage: error.message,isLoading:false));
    }, (data) {
      emit.call(state.copyWith(status: HomeStatus.loadingCategory,isLoading: true));
      emit.call(state.copyWith(status:
      HomeStatus.apiSuccessCategoryDeatils,categoryProperties: data.data,isLoading: false));
    });
  }
  Future<void> _onFetchFeaturedList(FeaturedLoaded event,
      Emitter<HomeState> emit) async {
    emit.call(state.copyWith(status: HomeStatus.loading,));
    final Either<ErrorResponse, RealEstateResponse> result =
    await repository.getFeaturedList();
    result.fold((error) {
      emit.call(state.copyWith(
          status: HomeStatus.error, errorMessage: error.message));
    }, (data) {
      emit.call(state.copyWith(status: HomeStatus.apiSuccessFeatured,featuredProperties: data.data));
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

