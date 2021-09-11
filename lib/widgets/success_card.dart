import 'package:flutter/material.dart';
import 'package:weather_app2/models/weather.dart';

class SuccessCard extends StatelessWidget {
  const SuccessCard({
    Key key,
    @required this.d24,
    @required this.dailyOrHourly,
    @required this.weather,
    @required this.index,
  }) : super(key: key);

  final String d24;
  final List dailyOrHourly;
  final Weather weather;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      child: ExpansionTile(
        title: Container(child:  Text(d24),),
        children: [
          Column(
            children: [
              Text(dailyOrHourly[index].description),
              Image.network("https://openweathermap.org/img/wn/${weather.hourly[index].iconCode}@2x.png", scale: 2),
            ],
          ),
        ],
      ),
    );
  }
}