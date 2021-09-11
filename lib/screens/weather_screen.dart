
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app2/cubit/weather_cubit.dart';
import 'package:weather_app2/cubit/weather_state.dart';
import 'package:weather_app2/models/weather.dart';
import 'package:weather_app2/widgets/failure_widget.dart';
import 'package:weather_app2/widgets/success_card.dart';

import '../localization.dart';
import 'package:intl/intl.dart';




class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {


  @override
  void initState() {
   super.initState();
   SchedulerBinding.instance.addPostFrameCallback((_) {
     if(context.read<WeatherCubit>().isHowAlert) {
       showDialog(
           context: context,
           builder: (ctx) {
             return Platform.isAndroid ? AlertDialog(
               content:  Text(WeatherLocalizations.of(context).getTitleWeatherDialog),
               actions: [
                 new FlatButton(
                   child:  Text(WeatherLocalizations.of(context).yes),
                   onPressed: () => Navigator.pop(ctx),
                 ),
                 new FlatButton(
                     child:  Text(WeatherLocalizations.of(context).no),
                     onPressed: () {
                       context.read<WeatherCubit>().tryAfainGetCurrentWeatherWithPosition();
                       Navigator.pop(ctx);
                     }
                 ),
               ],
             ) : CupertinoAlertDialog(
               content:  Text(WeatherLocalizations.of(context).getTitleWeatherDialog),
               actions: [
                 new FlatButton(
                   child:  Text(WeatherLocalizations.of(context).yes,style: TextStyle(color: Colors.black),),
                   onPressed: () => Navigator.pop(ctx),
                 ),
                 new FlatButton(
                     child:  Text(WeatherLocalizations.of(context).no,style: TextStyle(color: Colors.black),),
                     onPressed: () {
                       context.read<WeatherCubit>().tryAfainGetCurrentWeatherWithPosition();
                       Navigator.pop(ctx);
                     }
                 ),
               ],
             );
           }

       );
     }
   });

  }


  @override
  void didChangeDependencies() {
    context.read<WeatherCubit>().getCurrentWeatherWithPosition();
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    return WeatherVIew();
  }


}

class WeatherVIew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar:  _appBar(context),
      body:  BlocBuilder<WeatherCubit,WeatherState>(
        builder: (context,state) {
          if(state.status == WeatherStatus.loading) {
            return Center(child: Platform.isAndroid ? CircularProgressIndicator() : CupertinoActivityIndicator(),);
          }
          else if(state.status == WeatherStatus.success) {
            Weather weather = state.weather;
            List<dynamic> dailyOrHourly = weather.isDaily ? weather.daily : weather.hourly;
            return Column(
              children: [
                Text("timezone: ${weather.city}"),
                Expanded(
                  child: ListView.builder(
                      itemCount: dailyOrHourly.length,
                      itemBuilder: (ctx,i) {
                        var tag = Localizations.maybeLocaleOf(context)?.toLanguageTag();
                        DateTime parsedTime = dailyOrHourly[i].time.isNotEmpty ?
                        DateTime.fromMillisecondsSinceEpoch(int.tryParse(dailyOrHourly[i].time) * 1000) : DateTime.now();
                        String d24 = DateFormat(context.read<WeatherCubit>().strFormat,tag).format(parsedTime);
                        return SuccessCard(d24: d24, dailyOrHourly: dailyOrHourly, weather: weather,index: i);
                      }
                  ),
                ),
              ],
            );
          }
          else if(state.status == WeatherStatus.failure) {
            return FailureWidget();
          }
          else {
            return Container(
              child: Container(),
            );
          }
        },
      ),
    );
  }
//child: Icon(Icons.more_vert),
  AppBar _appBar(BuildContext context) {
    return AppBar(
      actions: [
        RotatedBox(
          quarterTurns: 1,
          child: PopupMenuButton<String>(
            onSelected: context.watch<WeatherCubit>().handleClick,
            itemBuilder: (BuildContext context) {
              return {WeatherLocalizations.of(context).dropDownHours, WeatherLocalizations.of(context).dropDownDaily}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ),
      ],
      //:
      title: Text(WeatherLocalizations.of(context).title,style: TextStyle(fontSize: 24,color: Colors.black),),
    );
  }


}



