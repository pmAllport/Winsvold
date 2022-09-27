import 'package:flutter/material.dart';
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
            child: const SettingsClassViewContainer()));
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
    _settingsBlocProvider.add(const SettingsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      if (state is SettingsLoading) {
        return Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        );
      } else if (state is SettingsSuccess) {
        return Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
          child: SizedBox(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26, width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  settingsCard(state.server),
                  settingsCard(state.name),
                  settingsCard(state.token),
                ],
              ),
            ),
          ),
        );
      } else if (state is SettingsFailed) {
        return Container(
          alignment: Alignment.center,
          child: const Text("En feil har oppstått"),
        );
      } else {
        return Container(
          alignment: Alignment.center,
          child: const Text("En feil har oppstått"),
        );
      }
    });
  }
}

Widget settingsCard(String settingsString) {
  return SizedBox(
    height: 100,
    child: Card(
      child: TextFormField(
        initialValue: settingsString,
        validator: (String? value) {
          return (value != null) ? 'Feltet kan ikke være tomt.' : null;
        },
      ),
    ),
  );
}
