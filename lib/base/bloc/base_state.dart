
part of 'base_bloc.dart';

abstract class BaseState {
  const BaseState();

  @override
  String toString() => runtimeType.toString();
}

class BaseInitial extends BaseState {}

class BaseLoadingState extends BaseState {
  final bool isLoading;
  const BaseLoadingState({required this.isLoading});
}
abstract class BaseStateWithLoading extends BaseState {
  late final bool isLoading;

  BaseStateWithLoading copyWith({bool isLoading});
}
class BaseErrorState extends BaseState {
  final String error;
  const BaseErrorState({required this.error});
}