part of 'theme_bloc.dart';
abstract class ThemeEvent extends BaseEvent {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleTheme extends ThemeEvent {
  final Brightness brightness;

  const ToggleTheme({required this.brightness});

  @override
  List<Object> get props => [brightness];
}

class LoadTheme extends ThemeEvent {}

class SaveTheme extends ThemeEvent {}
