part of 'property_bloc.dart';

abstract class PropertyEvent extends BaseEvent {}

// Load property events
class LoadAllProperties extends PropertyEvent {}

class LoadFeaturedProperties extends PropertyEvent {}

class LoadRecommendedProperties extends PropertyEvent {}

// Property detail events
class LoadPropertyDetails extends PropertyEvent {
  final String propertyId;

  LoadPropertyDetails(this.propertyId);

  @override
  List<Object?> get props => [propertyId];
}

// Property actions
class ToggleFavoriteProperty extends PropertyEvent {
  final String propertyId;
  final String propertyType;

  ToggleFavoriteProperty({
    required this.propertyId,
    required this.propertyType,
  });

  @override
  List<Object?> get props => [propertyId, propertyType];
}

class SendPropertyEnquiry extends PropertyEvent {
  final String propertyId;

  SendPropertyEnquiry({required this.propertyId});

  @override
  List<Object?> get props => [propertyId];
}

// Filter events
class FilterPropertiesByType extends PropertyEvent {
  final String propertyType;

  FilterPropertiesByType(this.propertyType);

  @override
  List<Object?> get props => [propertyType];
}

class SearchProperties extends PropertyEvent {
  final String query;

  SearchProperties(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearMessages extends PropertyEvent {}