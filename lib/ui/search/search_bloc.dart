import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:jre_app/base/bloc/base_bloc.dart';

import '../../../data/lib/base/error_response.dart';

import '../../../domain/model/home/proparty_model.dart';
import '../../../domain/repositry/home/repositry_random.dart';
import 'search_event.dart';
import 'search_state.dart';
class SearchBloc extends BaseBloc<SearchEvent, SearchState> {
  final RealEstateRepositoryType  repository ;

  SearchBloc(this.repository) : super(initialState: SearchState.initial()) {
    on<FilterResult>(_onFilterSearch);
  }

  // facility: [
  // FacilityModel(title: "WiFi", img: "assets/images/images/wifi.png"),
  // FacilityModel(title: "Pool", img: "assets/images/images/pool.png"),
  // FacilityModel(title: "Gym", img: "assets/images/images/gym.png"),
  // FacilityModel(title: "Parking", img: "assets/images/images/parking.png"),
  // FacilityModel(title: "AC", img: "assets/images/images/ac.png"),
  // FacilityModel(title: "Kitchen", img: "assets/images/images/kitchen.png"),
  // ],

  Future<void> _onFilterSearch(FilterResult event,
      Emitter<SearchState> emit) async {
    emit.call(state.copyWith(status: SearchStatus.loading,));
    final Either<ErrorResponse, PropertyCategoryResponse> result =
    await repository.getFilter(request: event.request);
    result.fold((error) {
      emit.call(state.copyWith(
          status: SearchStatus.error, errorMessage: error.message));
    }, (data) {
      emit.call(state.copyWith(status: SearchStatus.SearchSuccsess,filteredProperties: data.data));
    });
  }
}

