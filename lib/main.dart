import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'appString.dart';
import 'app_localization/localization_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocal(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Locale _locale = const Locale('en', 'US');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      locale: _locale,
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', "US"), // English
        Locale('ar', "SA"), // Saudi
        Locale('hi', "IN"), // Hindi
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale?.languageCode &&
              locale.countryCode == deviceLocale?.countryCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            Container(color: Colors.blue, height: 150),
            ListTile(
              onTap: () {
                MyApp.setLocal(context, const Locale("en", "US"));
                Navigator.pop(context);
              },
              title: Text(AppString.english),
            ),
            ListTile(
              onTap: () {
                MyApp.setLocal(context, const Locale("hi", "IN"));
                Navigator.pop(context);
              },
              title: Text(AppString.hindi),
            ),
            ListTile(
              onTap: () {
                MyApp.setLocal(context, const Locale("ar", "SA"));
                Navigator.pop(context);
              },
              title: Text(AppString.turkish),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  hintText: AppLocalization.of(context)
                      .getConvertedValue(AppString.entername)),
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: AppLocalization.of(context)
                      .getConvertedValue(AppString.enterpassword)),
            ),
            const SizedBox(height: 20),
            Text(
                "${AppLocalization.of(context).getConvertedValue(AppString.forgotpassword)}"),
          ],
        ),
      ),
    );
  }
}
