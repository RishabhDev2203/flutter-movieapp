import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../locale/application_localizations.dart';
import 'apptheme.dart';
import 'theme_models.dart';
import '../util/app_colors.dart';
import '../util/component/back_button.dart';
import '../util/component/my_container.dart';
import '../util/dimensions.dart';

class ChangeTheme extends StatefulWidget {
  const ChangeTheme({Key? key}) : super(key: key);

  @override
  _ChangeThemeState createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  late ThemeMode _selectedThemeMode;
  final _darkTheme = true;
  final _lightTheme = true;
  int selectedRadio = 0;
  final List _options = [
    {"title": 'System', "value": ThemeMode.system},
    {"title": 'Light', "value": ThemeMode.light},
    {"title": 'Dark', "value": ThemeMode.dark}
  ];

  @override
  void initState() {
    selectedRadio = 0;
    super.initState();
  }

  @override
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  List<Widget> _createOptions(ThemeNotifier themeModeNotifier) {
    List<Widget> widgets = [];
    for (Map option in _options) {
      widgets.add(
        RadioListTile<dynamic>(
          value: option['value'],
          groupValue: _selectedThemeMode,
          title: Text(option['title'],style: TextStyle(color: AppColors.white,fontWeight: FontWeight.w500),),
          onChanged: (mode) {
            _setSelectedThemeMode(mode, themeModeNotifier);
          },
          selected: _selectedThemeMode == option['value'],
            activeColor: Colors.white,

        ),
      );
    }
    return widgets;
  }

  void _setSelectedThemeMode(
      ThemeMode mode, ThemeNotifier themeModeNotifier) async {
    themeModeNotifier.setThemeMode(mode);
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', mode.index);
    setState(() {
      _selectedThemeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    setState(() {
      _selectedThemeMode = themeNotifier.getThemeMode();
    });
    return Container(
      decoration: AppColors.bgGradientBoxDecoration(),
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Container(
              padding: const EdgeInsets.only(
                left: Dimensions.marginMedium,
                right: Dimensions
                    .marginMedium, /* top: MediaQuery.of(context).padding.top + 30*/
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: ButtonBack(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                        ApplicationLocalizations.of(context)!
                            .translate("changeTheme")!,
                        style: Theme.of(context).textTheme.headline1),
                    const SizedBox(height: 25),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 25, bottom: 25, left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: AppColors.myContainerColor,
                        borderRadius: BorderRadius.circular(
                            Dimensions.cornerRadiusMedium),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: _createOptions(themeNotifier),

                          ),
                        ],
                      ),
                    ),
                  ]))),
    );
  }
}
