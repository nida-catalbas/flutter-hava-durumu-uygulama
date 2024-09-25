import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/models/weatherModel.dart';
class Weatherservices{
 Future<String>  getLocation() async{
   final serviceenabled= await Geolocator.isLocationServiceEnabled();
   if(!serviceenabled){
     Future.error('konum servisiniz kapalı');
   }
   LocationPermission permission = await Geolocator.checkPermission();
   if(permission== LocationPermission.denied){
     permission = await Geolocator.requestPermission();
     if(permission== LocationPermission.denied){
       Future.error('Konuma izin vermelisiniz');
     }
   }
   final Position position= await Geolocator.getCurrentPosition(
       locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
   );
   final List<Placemark> placemark =await placemarkFromCoordinates(position.latitude, position.longitude);
   if(placemark.isNotEmpty){
     print(placemark);
     String? city=placemark[0].administrativeArea;
     if(city == null || city.isEmpty){
       return Future.error('Şehir bulunmadı');
     }
     return city;
   }else{
     return Future.error('placemark boş geldi');
   }



 }
 Future<List<Weathermodel>> getWeatherData() async{
   final String city=await getLocation();

   final String url='https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$city';
   const Map<String,dynamic> headers={
    "authorization": "apikey 05XAxu9mzq7ztTrWSMYAKb:3swgtbyCcFmnqH583akncP",
     "content-type":"application/json"
   };
   final dio=Dio();
   final response= await dio.get(url, options: Options(headers: headers));
   if(response.statusCode!=200) {
     return Future.error('bir sorun var');
   }
   print(response.data);
   final List list=response.data['result'];
   final List<Weathermodel> weatherList=
   list.map((e)=>Weathermodel.fromJson(e)).toList();

   return weatherList;

 }


}