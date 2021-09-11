

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/screens/splash_screen.dart';
import 'package:weather_app2/screens/weather_screen.dart';
import 'package:weather_app2/services/weather_repository.dart';
import 'cubit/weather_cubit.dart';
import 'localization.dart';
import 'package:intl/intl.dart';



void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  final WeatherRepository _weatherRepository = WeatherRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(_weatherRepository),
      child: MaterialApp(
        localizationsDelegates: const [
          WeatherLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ru', ''),
        ],
        // Watch out: MaterialApp creates a Localizations widget
        // with the specified delegates. DemoLocalizations.of()
        // will only find the app's Localizations widget if its
        // context is a child of the app.
        //title: WeatherLocalizations.of(context).title,
        //onGenerateTitle: (BuildContext context) => WeatherLocalizations.of(context).title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen()
      ),
    );
  }
}

// class DemoApp extends StatelessWidget {
//   const DemoApp({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//      String currentLocale = Intl.getCurrentLocale();
//      print("Current locale: $currentLocale");
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(WeatherLocalizations.of(context).title),
//       ),
//       body: Center(
//         child: Text(WeatherLocalizations.of(context).description),
//       ),
//     );
//   }
// }


