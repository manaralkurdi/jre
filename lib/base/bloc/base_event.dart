// base_event.dart
part of 'base_bloc.dart';

abstract class BaseEvent {
  const BaseEvent();

  @override
  String toString() => runtimeType.toString();
}

class BaseLoadingEvent extends BaseEvent {
  final bool isLoading;
  const BaseLoadingEvent(this.isLoading);
}

class BaseErrorEvent extends BaseEvent {
  final String error;
  const BaseErrorEvent(this.error);
}

class BaseClearErrorEvent extends BaseEvent {}