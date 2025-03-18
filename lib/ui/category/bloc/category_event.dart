
import 'package:jre_app/base/bloc/base_bloc.dart';

abstract class CategoryEvent extends BaseEvent {}


class CategoryDetailsLoaded extends CategoryEvent {
  int? id;

  CategoryDetailsLoaded({this.id});
}


class ToggleFavoriteEvent extends CategoryEvent {
  final String propertyId;
  final String propertyType;

  ToggleFavoriteEvent({
    required this.propertyId,
    required this.propertyType,
  });
}

