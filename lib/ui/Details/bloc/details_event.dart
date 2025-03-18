
import 'package:jre_app/base/bloc/base_bloc.dart';

abstract class DetailsEvent extends BaseEvent {}

class LoadPropertyDetailsEvent extends DetailsEvent {
  final int propertyId;

  LoadPropertyDetailsEvent({required this.propertyId});
}

class ToggleFavoriteEvent extends DetailsEvent {
  final String propertyId;
  final String propertyType;

  ToggleFavoriteEvent({
    required this.propertyId,
    required this.propertyType,
  });
}

