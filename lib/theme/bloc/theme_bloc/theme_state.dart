part of 'theme_bloc.dart';
enum ThemeStatus { initial, loading, lightTheme, darkTheme }

class ThemeState extends BaseState {
  final ThemeStatus status;
  final ThemeMode themeMode;

  const ThemeState({
    required this.status,
    required this.themeMode,
  });

  factory ThemeState.initial() => const ThemeState(
    status: ThemeStatus.initial,
    themeMode: ThemeMode.system,
  );

  @override
  List<Object> get props => [status, themeMode];

  ThemeState copyWith({
    ThemeStatus? status,
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      status: status ?? this.status,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'status': status.index,
      'themeMode': themeMode.index,
    };
  }

  static ThemeState fromMap(Map<String, dynamic> map) {
    return ThemeState(
      status: ThemeStatus.values[map['status'] ?? 0],
      themeMode: ThemeMode.values[map['themeMode'] ?? 0],
    );
  }
}
