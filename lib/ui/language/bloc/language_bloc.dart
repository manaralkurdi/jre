import 'package:bloc/bloc.dart';
import 'package:jre_app/ui/language/bloc/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/bloc/base_bloc.dart';

part 'language_event.dart';

part 'language_state.dart';

class LanguageBloc extends BaseBloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(initialState: LanguageState.initial()) {
    on<LanguageSelected>(_onLanguageSelected);
    _initLanguages();
    // on<ToggleTheme>(_toggleTheme);
    // on<LoadTheme>(_loadTheme);
    // on<SaveTheme>(_saveTheme);
  }

  void _initLanguages() {
    final languages = [
      Language(
        code: 'en',
        name: 'English (US)',
        flagImage: 'assets/flags/us.png',
      ),
      Language(code: 'ar', name: 'Arabic', flagImage: 'assets/flags/sa.png'),
    ];

    add(LanguageSelected('en'));
    emit(
      state.copyWith(
        status: LanguageStatus.languageLoaded,
        languages: languages,
      ),
    );
    _loadSavedLanguage();
  }

  Future<void> _onLanguageSelected(
    LanguageSelected event,
    Emitter<LanguageState> emit,
  ) async {
    emit(state.copyWith(status: LanguageStatus.loading));

    final selectedLanguage = state.languages?.firstWhere(
      (language) => language.code == event.languageCode,
      orElse:
          () => Language(
            code: 'en',
            name: 'English (US)',
            flagImage: 'assets/flags/us.png',
          ),
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', event.languageCode);

    emit(
      state.copyWith(
        status: LanguageStatus.languageLoaded,
        selectedLanguage: selectedLanguage,
      ),
    );
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'en';
    add(LanguageSelected(languageCode));
  }
}
// Here are the part files
