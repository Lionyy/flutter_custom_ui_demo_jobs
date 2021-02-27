import 'package:flutter/material.dart';
import 'app_options.dart';
import 'app_theme_data.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
    this.isTestMode = false,
  }) : super(key: key);

  final bool isTestMode;

  @override
  Widget build(BuildContext context) => ModelBinding(
      initialModel: AppOptions(
        themeMode: ThemeMode.system,
        isTestMode: isTestMode,
      ),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            restorationScopeId: 'rootApp',
            title: 'Flutter Test App',
            themeMode: AppOptions.of(context).themeMode,
            theme: AppThemeData.lightThemeData,
            darkTheme: AppThemeData.darkThemeData,
            home: MyHomePage(title: 'Custom UI'),
          );
        },
      ),
    );
}