
class Daily {
  String description;
  String iconCode;
  String time;
  String tempDay;
  String tempMax;
  String tempMin;

  Daily({this.description, this.iconCode, this.time,this.tempDay, this.tempMax,this.tempMin});

  Daily copyWith({
    final String description,
    final String iconCode,
    final  String time,
    final String tempDay,
    final String tempMax,
    final String tempMin,
  }) {
    return Daily(
        description: description ?? this.description,
        iconCode: iconCode ?? this.iconCode,
        time: time ?? this.time,
        tempDay: tempDay ?? this.tempDay,
        tempMax: tempMax ?? this.tempMax,
        tempMin: tempMin ?? this.tempMin
    );
  }

  Map<String, dynamic> toJson() {
    return {
     "description": description,
      "icon": iconCode,
      "dt": time,
      'day': tempDay,
      'min': tempMin,
       "max": tempMax,
  };

  }

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      iconCode: json['weather'][0]['icon'],
       description: json['weather'][0]['description'],
       time: json['dt'].toString() ,
       tempDay: json['temp']['day'].toString() ,
       tempMin: json['temp']['min'].toString(),
       tempMax: json['temp']['max'].toString() ,
    );
  }

  factory Daily.fromStorage(Map<String, dynamic> json) {
    return Daily(
      iconCode: json['icon'],
      description: json['description'],
      time: json['dt'].toString(),
      tempDay: json['day'],
      tempMin: json['min'],
      tempMax: json['max'],
    );
  }

}

/// Hourly
class Hourly {
  String description;
  String iconCode;
  String time;
  String temp;

  Hourly({this.description, this.iconCode, this.time,this.temp,});

  Hourly copyWith({
    final String description,
    final String iconCode,
    final  String time,
    final String tempDay,
    final String tempMax,
    final String tempMin,
  }) {
    return Hourly(
        description: description ?? this.description,
        iconCode: iconCode ?? this.iconCode,
        time: time ?? this.time,
      temp: tempDay ?? this.temp,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "icon": iconCode,
      "dt": time,
      'temp': temp,
    };

  }

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      iconCode: json['weather'][0]['icon'],
      description: json['weather'][0]['description'],
      time: json['dt'].toString(),
      temp: json['temp'].toString()
    );
  }

  factory Hourly.fromStorage(Map<String, dynamic> json) {
    return Hourly(
      iconCode: json['icon'],
      description: json['description'],
      time: json['dt'].toString(),
      temp: json['temp'].toString(),
    );
  }

}


class Weather {
  bool isDaily = false;
  //bool isExpanded = false;
  final String city;
  final String lat;
  final String lon;
  final List<Daily> daily;
  final List<Hourly> hourly;


  Weather(
      {this.isDaily,
       // this.isExpanded,
        this.city,
        this.lat,
        this.lon,
        this.daily,
        this.hourly
        });

  Weather copyWith({
    final String city,
    final bool isDaily,
    final String lat,
    final String lon,
    final List<Daily> daily,
    final List<Hourly> hourly,
  }) {
    return Weather(
      city: city ?? this.city,
      isDaily: isDaily ?? this.isDaily,
      lon: lon ?? this.lon,
      lat: lat ?? this.lat,
      daily: daily ?? this.daily,
      hourly: hourly ?? this.hourly,

    );
  }

  static final empty = Weather(
      isDaily: false,
     // isExpanded: false,
      city: "",
      lat: "",
      lon: "",
      daily: [],
      hourly: []
  );

  factory Weather.fromStorage(Map<String, dynamic> json) {
    List<dynamic> dailyList = json['daily'];
    List<dynamic> hourlyList = json['hourly'];
    return Weather(
       //  isExpanded: json["isExpanded"],
         isDaily: json['isDaily'] ?? false,
         city: json['city'].toString(),
         lat: json['lat'.toString()],
         lon: json['lon'].toString(),
         daily: dailyList.map((e) => Daily.fromStorage(e)).toList(),
         hourly: hourlyList.map((e) => Hourly.fromStorage(e)).toList(),

    );
  }


  factory Weather.fromJson(Map<String, dynamic> json) {
    List<dynamic> dailyList = json['daily'];
    List<dynamic> hourlyList = json['hourly'];
    return Weather(
      isDaily: json['isDaily'] ?? false,
      lat: json['lat'].toString(),
      lon: json['lon'].toString(),
      city: json['timezone'].toString(),
      daily: dailyList.map((e) => Daily.fromJson(e)).toList(),
      hourly: hourlyList.map((e) => Hourly.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //'isExpanded': this.isExpanded,
      "lat": lat,
      "lon": lon,
      "isDaily": isDaily,
      "city": city,
      "daily": daily.map((e) => e.toJson()).toList(),
      "hourly": hourly.map((e) => e.toJson()).toList()

    };

  }
}