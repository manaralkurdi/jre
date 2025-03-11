import 'package:jre_app/base/bloc/base_bloc.dart';

abstract class HomeEvent extends BaseEvent {}

class LoadHomeDataEvent extends HomeEvent {}

class FilterPropertiesEvent extends HomeEvent {
  final String propertyType;

  FilterPropertiesEvent(this.propertyType);
}