part of 'language_bloc.dart';

enum LanguageStatus { initial, loading, languageLoaded  }

class LanguageState extends BaseState {
  final LanguageStatus status;
  final Language? selectedLanguage;
  final List<Language>? languages;

  const LanguageState({
    required this.status,
    this.languages,
    this.selectedLanguage,
  });

  factory LanguageState.initial() => LanguageState(
      status: LanguageStatus.initial,
      languages: [],
      selectedLanguage: Language(code: 'en', flagImage: '', name: '')
  );

  LanguageState copyWith({
    LanguageStatus? status,
    Language? selectedLanguage,
    List<Language>? languages,
  }) {
    return LanguageState(
      status: status ?? this.status,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      languages: languages ?? this.languages,
    );
  }

  List<Object> get props => [status, languages ?? [], selectedLanguage ?? Language(code: '', flagImage: '', name: '')];
}