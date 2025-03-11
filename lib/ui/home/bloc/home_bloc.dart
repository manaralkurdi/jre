import 'package:bloc/bloc.dart';
import 'package:jre_app/base/bloc/base_bloc.dart';

import 'home_event.dart';
import 'home_repo.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(initialState: HomeState.initial()) {
    on<LoadHomeDataEvent>(_onLoadHomeData);
    on<FilterPropertiesEvent>(_onFilterProperties);
    // on<FetchUserLocation>(_onFetchUserLocation); on<HomeEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }

  Future<void> _onLoadHomeData(
    LoadHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    PropertyRepository? repository = PropertyRepository();

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final properties = await repository.getProperties();

      // For simplicity, we'll use the same list for featured and recommended
      // In a real app, these would come from different API endpoints
      emit(
        state.copyWith(
          isLoading: false,
          featuredProperties: properties,
          recommendedProperties: properties,
          filteredProperties: properties,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load properties: ${e.toString()}',
        ),
      );
    }
  }

  void _onFilterProperties(
    FilterPropertiesEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(
        isLoading: true,
        selectedPropertyType: event.propertyType,
        errorMessage: null,
      ),
    );

    try {
      if (event.propertyType == 'All') {
        emit(
          state.copyWith(
            isLoading: false,
            filteredProperties: state.featuredProperties,
          ),
        );
      } else {
        final filteredProperties =
            state.featuredProperties
                .where((property) => property.type == event.propertyType)
                .toList();
        emit(
          state.copyWith(
            isLoading: false,
            filteredProperties: state.featuredProperties,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to filter properties: ${e.toString()}',
        ),
      );
    }
  }
}
