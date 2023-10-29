import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'home_screen.dart';
import 'registration_screen.dart';
import 'login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Color myColor = Color(0xFFDBCDFF);

  Future<bool> _checkIfUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userLoggedIn = prefs.getBool('user_logged_in');
    return userLoggedIn == true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Wave',
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          toolbarHeight: 70.0,
          elevation: 4,
          centerTitle: true,
        ),
        colorScheme: ColorScheme.light(
          primary: myColor,
          secondary: myColor,
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        const FallbackCupertinoLocalisationsDelegate(),
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('pt', 'BR'),
      ],
      home: FutureBuilder<bool>(
        future: _checkIfUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            final userLoggedIn = snapshot.data ?? false;
            return userLoggedIn ? HomeScreen() : RegistrationScreen();
          }
        },
      ),
    );
  }
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}
