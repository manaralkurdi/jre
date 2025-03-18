import 'package:jre_app/base/bloc/base_bloc.dart';

import '../../../domain/model/home/filter_request.dart';

abstract class HomeEvent extends BaseEvent {}

class LoadHomeDataEvent extends HomeEvent {}


class RealEstateRandomLoaded extends HomeEvent {
  RealEstateRandomLoaded();
}

class FeaturedLoaded extends HomeEvent {
  FeaturedLoaded();
}

class CategoryDetailsLoaded extends HomeEvent {
  int? id;

  CategoryDetailsLoaded({this.id});
}


// Property actions
class ToggleFavoriteProperty extends HomeEvent {
  final String propertyId;
  final String propertyType;

  ToggleFavoriteProperty({
    required this.propertyId,
    required this.propertyType,
  });

  @override
  List<Object?> get props => [propertyId, propertyType];
}
