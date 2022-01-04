import 'package:equatable/equatable.dart';

enum Status { Settings, amount, overview }

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsLoading extends SettingsState {}

class SettingsFailed extends SettingsState {}

class SettingsSuccess extends SettingsState {
  final String server;
  final String name;
  final String token;

  const SettingsSuccess(
      {required this.server, required this.name, required this.token});

  @override
  List<Object> get props => [server, name, token];
}

class SettingsInsertedSuccess extends SettingsState {
  const SettingsInsertedSuccess();

  @override
  List<Object> get props => [];
}
