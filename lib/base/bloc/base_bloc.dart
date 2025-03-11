
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

part 'base_event.dart';

part 'base_state.dart';

abstract class BaseBloc<T extends BaseEvent, S extends BaseState>
    extends Bloc<T, S> {
  // Add status tracking
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _lastError;

  String? get lastError => _lastError;


  BaseBloc({BaseState? initialState})
      : super(
      initialState != null ? (initialState as S) : (BaseInitial() as S)) {
    onCreate();
  }

  // Lifecycle methods
  @protected
  void onCreate() {}

  @override
  Future<void> close() async {

  }

  @protected
  void emitLoading(bool loading) {
    _isLoading = loading;

    if (!isClosed) {
      if (state is BaseStateWithLoading) {
        emit((state as BaseStateWithLoading).copyWith(isLoading: loading) as S);
      } else {
        developer.log(
          'Warning: emitLoading called, but state does not support loading.',
          name: 'BaseBloc',
        );
      }
    }
  }

  @protected
  void emitError(String error) {
    _lastError = error;
    if (!isClosed) {
      emit(BaseErrorState(error: error) as S);
    }
  }

  @protected
  void emitInitial() {
    _lastError = null;
    if (!isClosed) {
      emit(BaseInitial() as S);
    }
  }


  // Enhanced error handling
  @override
  void add(T event) {
    try {
      developer.log('Adding event: ${event.runtimeType}', name: 'BaseBloc');
      super.add(event);
    } catch (e, stackTrace) {
      developer.log(
        'Error adding event: $e',
        name: 'BaseBloc',
        error: e,
        stackTrace: stackTrace,
      );
      emitError(e.toString());
    }
  }

  // Utility method for handling async operations
  @protected
  Future<void> safeEmit(S state) async {
    if (!isClosed) {
      emit(state);
    }
  }

  // Helper method for safe async operations
  @protected
  Future<void> executeAsync<R>(
      Future<R> Function() operation,
      S Function(R result) onSuccess, {
        bool showLoading = true,
        String? errorMessage,
      }) async {
    if (showLoading) {
      emitLoading(true);
    }

    try {
      final result = await operation();
      if (!isClosed) {
        emit(onSuccess(result));
      }
    } catch (e, stackTrace) {
      developer.log(
        'Operation failed: $e',
        name: 'BaseBloc',
        error: e,
        stackTrace: stackTrace,
      );
      emitError(errorMessage ?? e.toString());
    } finally {
      if (showLoading) {
        emitLoading(false);
      }
    }
  }
}
