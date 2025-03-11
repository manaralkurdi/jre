part of 'language_bloc.dart';

abstract class LanguageEvent extends BaseEvent {
  LanguageEvent();

  List<Object> get props => [];
}

class LanguageSelected extends LanguageEvent {
  final String languageCode;

   LanguageSelected(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}

class FetchLanguages extends LanguageEvent {
   FetchLanguages();
}
