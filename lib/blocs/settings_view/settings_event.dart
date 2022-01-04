import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List get props => [];
}

class SettingsRequested extends SettingsEvent {
  const SettingsRequested();

  @override
  List get props => [];
}

class SettingsInserted extends SettingsEvent {
  final String server;
  final String name;
  final String token;
  const SettingsInserted(
      {required this.server, required this.name, required this.token});

  @override
  List get props => [];
}
