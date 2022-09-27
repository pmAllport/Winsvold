import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winsvold/blocs/settings_view/settings_bucket.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  String? name;
  String? server;
  String? token;

  SettingsBloc({this.name, this.server, this.token})
      : super(SettingsLoading()) {
    on<SettingsRequested>(_onSettingsRequested);
    on<SettingsInserted>(_onSettingsInserted);
  }

  void _onSettingsRequested(
      SettingsRequested event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String server = prefs.getString('server') ?? "";
      String name = prefs.getString('name') ?? "";
      String token = prefs.getString('token') ?? "";

      emit(SettingsSuccess(server: server, name: name, token: token));
    } catch (e) {
      emit(SettingsFailed());
    }
  }

  void _onSettingsInserted(
      SettingsInserted event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString("server", event.server);
      prefs.setString("name", event.name);
      prefs.setString("token", event.token);

      emit(SettingsInsertedSuccess());
    } catch (e) {
      emit(SettingsFailed());
    }
  }
}
