import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'home_screen.dart';
import 'study_methods.dart'; // Adicionei esta linha para importar o arquivo de métodos de estudo

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Color myColor = Color(0xFFDBCDFF);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Wave',
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          toolbarHeight: 70.0, // Defina a altura da faixa da AppBar aqui
          elevation: 4, // Ajuste a elevação da AppBar aqui
          centerTitle: true, // Centralize o título
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
      home: HomeScreen(),
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
