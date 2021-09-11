import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter_localizations/flutter_localizations.dart';

class WeatherLocalizations {
  WeatherLocalizations(this.locale);

  final Locale locale;

  static WeatherLocalizations of(BuildContext context) {
    return Localizations.of<WeatherLocalizations>(context, WeatherLocalizations);
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'title': 'Weather',
      'drop_down_hours': 'Hours',
      'drop_down_daily': 'Daily',
      "dialog_weather": "Show weather in current city?",
      "yes": "Yes",
      "no": "No"

    },
    'ru': {
      'title': 'Погода',
      'drop_down_hours': 'Часы',
      'drop_down_daily': 'Дни',
       "dialog_weather": "Показать погоду в текущем городе?",
      "yes": "Да",
      "no": "Нет"
    },
  };

  static List<String> languages () => _localizedValues.keys.toList();

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }

  String get dropDownHours {
    return _localizedValues[locale.languageCode]['drop_down_hours'];
  }

  String get dropDownDaily {
    return _localizedValues[locale.languageCode]['drop_down_daily'];
  }

  String get getTitleWeatherDialog {
    return _localizedValues[locale.languageCode]['dialog_weather'];
  }
  String get yes {
    return _localizedValues[locale.languageCode]['yes'];
  }
  String get no {
    return _localizedValues[locale.languageCode]['no'];
  }
}

class WeatherLocalizationsDelegate
    extends LocalizationsDelegate<WeatherLocalizations> {
  const WeatherLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => WeatherLocalizations.languages().contains(locale.languageCode);


  @override
  Future<WeatherLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<WeatherLocalizations>(WeatherLocalizations(locale));
  }

  @override
  bool shouldReload(WeatherLocalizationsDelegate old) => false;
}