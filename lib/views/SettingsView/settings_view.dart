import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winsvold/blocs/settings_view/settings_bucket.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Instillinger'),
        ),
        body: BlocProvider(
            create: (context) => SettingsBloc(),
            child: SettingsClassViewContainer()));
  }
}

class SettingsClassViewContainer extends StatefulWidget {
  const SettingsClassViewContainer({Key? key}) : super(key: key);

  @override
  _SettingsClassViewContainerState createState() =>
      _SettingsClassViewContainerState();
}

class _SettingsClassViewContainerState
    extends State<SettingsClassViewContainer> {
  late SettingsBloc _settingsBlocProvider;
  @override
  void initState() {
    super.initState();
    _settingsBlocProvider = BlocProvider.of<SettingsBloc>(context);
    _settingsBlocProvider.add(SettingsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      if (state is SettingsLoading) {
        return Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      } else if (state is SettingsSuccess) {
        return SizedBox(
          height: 500,
          width: 300,
          child: Row(
            children: [Text(state.server), Text(state.name), Text(state.token)],
          ),
        );
      } else if (state is SettingsFailed) {
        return Container(
          alignment: Alignment.center,
          child: Text("En feil har oppstått"),
        );
      } else {
        return Container(
          alignment: Alignment.center,
          child: Text("En feil har oppstått"),
        );
      }
    });
  }
}
