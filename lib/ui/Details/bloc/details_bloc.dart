import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:jre_app/base/bloc/base_bloc.dart';

import '../../../data/lib/base/error_response.dart';
import '../../../domain/model/home/details.dart' show DetailsProperty, PropertyData;

import '../../../domain/repositry/home/repositry_random.dart';
import 'details_event.dart';
import 'details_state.dart';

class DetailsBloc extends BaseBloc<DetailsEvent, DetailsState> {
  final RealEstateRepositoryType  repository ;

  DetailsBloc(this.repository) : super(initialState: DetailsState.initial()) {
    on<LoadPropertyDetailsEvent>(_onDetailsList);
    // on<FetchUserLocation>(_onFetchUserLocation); on<SearchEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }


  Future<void> _onDetailsList(LoadPropertyDetailsEvent event,
      Emitter<DetailsState> emit) async {
    emit.call(state.copyWith(status: DetailsStatus.loading,isLoading: true));
    final Either<ErrorResponse, DetailsProperty> result =
    await repository.getDetails(id: event.propertyId);
    result.fold((error) {
      emit.call(state.copyWith(
          status: DetailsStatus.error, errorMessage: error.message));
    }, (data) {
      emit.call(state.copyWith(status: DetailsStatus.loading,isLoading: true));
      emit.call(state.copyWith(status: DetailsStatus.apiSuccessDetails,
          detailsProperties: data,isLoading: false));
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

