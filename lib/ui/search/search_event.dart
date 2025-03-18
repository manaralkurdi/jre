import 'package:jre_app/base/bloc/base_bloc.dart';

import '../../../domain/model/home/filter_request.dart';

abstract class SearchEvent extends BaseEvent {}

class LoadHomeDataEvent extends SearchEvent {}

class RealEstateRandomLoaded extends SearchEvent {
  RealEstateRandomLoaded();
}

class FeaturedLoaded extends SearchEvent {
  FeaturedLoaded();
}

class FilterResult extends SearchEvent {
  RealEstateFilterRequest request;

  FilterResult(this.request);
}
