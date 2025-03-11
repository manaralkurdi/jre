import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/bloc/base_bloc.dart';

export 'package:flutter/material.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends BaseBloc<ThemeEvent, ThemeState> {
  static const String _themeStorageKey = 'app_theme_settings';

  ThemeBloc() : super(initialState: ThemeState.initial()) {
    on<ToggleTheme>(_toggleTheme);
    on<LoadTheme>(_loadTheme);
    on<SaveTheme>(_saveTheme);

    // Load theme data on initialization
    add(LoadTheme());
  }

  Future<void> _toggleTheme(ToggleTheme event, Emitter<ThemeState> emit) async {
    emitLoading(true);

    if (event.brightness == Brightness.dark) {
      await safeEmit(state.copyWith(
          status: ThemeStatus.darkTheme, themeMode: ThemeMode.dark));
    } else {
      await safeEmit(state.copyWith(
          status: ThemeStatus.lightTheme, themeMode: ThemeMode.light));
    }

    // Save theme preference after changing
    add(SaveTheme());
    emitLoading(false);
  }

  Future<void> _loadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    executeAsync<ThemeState?>(
            () => _loadThemeFromStorage(),
            (loadedState) => loadedState ?? _getSystemThemeState(),
        showLoading: true,
        errorMessage: 'Failed to load theme preferences'
    );
  }

  Future<void> _saveTheme(SaveTheme event, Emitter<ThemeState> emit) async {
    executeAsync<bool>(
            () => _saveThemeToStorage(),
            (success) => state,
        showLoading: false,
        errorMessage: 'Failed to save theme preferences'
    );
  }

  // Helper method to load theme from SharedPreferences
  Future<ThemeState?> _loadThemeFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_themeStorageKey);

      if (jsonString != null) {
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        return ThemeState.fromMap(jsonMap);
      }
    } catch (e) {
      // Forward the error to be handled by executeAsync
      throw Exception('Error loading theme: $e');
    }
    return null;
  }

  // Helper method to save theme to SharedPreferences
  Future<bool> _saveThemeToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonMap = state.toMap();
      final jsonString = json.encode(jsonMap);
      return await prefs.setString(_themeStorageKey, jsonString);
    } catch (e) {
      throw Exception('Error saving theme: $e');
    }
  }

  // Helper method to get system theme state
  ThemeState _getSystemThemeState() {
    final brightness = PlatformDispatcher.instance.platformBrightness;
    return ThemeState(
      status: brightness == Brightness.dark
          ? ThemeStatus.darkTheme
          : ThemeStatus.lightTheme,
      themeMode: brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}
// Here are the part files
