import 'dart:async';

import 'package:flutter/material.dart';
import 'models/weatherModel.dart';
import 'weatherServices.dart';
void main() {
  runApp(const Havadurum());
}
class Havadurum extends StatelessWidget {
  const Havadurum({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hava Durumu App',
      home: const WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
List<Weathermodel> _weather=[];
late String  city;
  void getWeatherData() async{
    _weather=await Weatherservices().getWeatherData();
    city=await Weatherservices().getLocation();
   setState(() {

   });
  }

  @override
  void initState(){
    Weatherservices().getLocation().then((value){
      print(value);
    }).catchError((error)=>print(error));
    getWeatherData();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bulunduğunuz şehir: '+city),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _weather.length,
            itemBuilder: (context,index){
            final Weathermodel weather=_weather[index];
            return Container(
              padding: const EdgeInsets.all(30),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.blueGrey,borderRadius: BorderRadius.circular(20)),

              child: Column(
                children: [
                  Text(weather.date,style: TextStyle(fontSize: 20,color: Colors.white24,),),
                  Image.network(weather.icon,width: 100,),



                  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,

                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.grey,style: BorderStyle.solid,),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),

                            )
                          ]
                        ),
                        child: Text(weather.durum+' ', style: TextStyle(fontSize: 18,color: Colors.black54)),
                        padding: EdgeInsets.all(20),

                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white12,
                        borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.white24,style: BorderStyle.solid),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),

                              )
                            ]),
                        child: Text(weather.derece+' C',style: TextStyle(fontSize: 22,color: Colors.black54),),
                      ),

                      

                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.grey,style: BorderStyle.solid,),
                            color: Colors.black12,
                         boxShadow: [
                         BoxShadow(
                         color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                           offset: Offset(0, 3),
                       )],
              
              ),
                        width: 150,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        child: Text('Gece : '+weather.gece+' C',style: TextStyle(fontSize: 20,color: Colors.white54),
                      ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:Colors.white70 ,

                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white70,style: BorderStyle.solid ),
                          boxShadow:[
                            BoxShadow(
                              color: Colors.white10,
                              spreadRadius: 3,
                              blurRadius: 6,
                              blurStyle: BlurStyle.solid,
                              offset: Offset(0,3)
                            )
                          ] ,
                        ),
                        padding: EdgeInsets.all(10),
                        height: 50,
                        width: 150,
                         margin: EdgeInsets.all(5),
                        child: Text('Nem : % '+weather.nem,style: TextStyle(fontSize: 22,color: Colors.black54) ,),
                      ),


                    ],
                  ),


                ],
              ),
            );
            }
        ),
      ),
    );
  }
}
