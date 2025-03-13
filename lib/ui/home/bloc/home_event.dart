import 'package:jre_app/base/bloc/base_bloc.dart';

import '../../../domain/model/home/filter_request.dart';

abstract class HomeEvent extends BaseEvent {}

class LoadHomeDataEvent extends HomeEvent {}

class FilterPropertiesEvent extends HomeEvent {
  final String propertyType;

  FilterPropertiesEvent(this.propertyType);
}

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

class PropertyDetailsLoaded extends HomeEvent {
  int? id;

  PropertyDetailsLoaded({this.id});
}
class FilterResult extends HomeEvent {
  RealEstateFilterRequest request;
  FilterResult(this.request);
}
