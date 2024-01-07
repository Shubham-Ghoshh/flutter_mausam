import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mausam/services/weather_service.dart';

import '../models/wetaher_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final String apiKey = "9de5afb7eb2c19e87f82797378d92c86";

  late WeatherService _weatherService;
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get the current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    //any errors
    catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/loading.json"; //default to sunny
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return "assets/clouds.json";
      case 'mist':
        return "assets/mist.json";
      case 'smoke':
        return "assets/smoke.json";
      case 'haze':
        return "assets/haze.json";
      case 'dust':
        return "assets/dust.json";
      case 'fog':
        return "assets/clouds.json";
      case 'rain':
        return "assets/raining.json";
      case 'drizzle':
        return "assets/drizzle.json";
      case 'shower rain':
        return "assets/shower_rain.json";
      case 'thunderstorm':
        return "assets/thunderstorm.json";
      case 'clear':
        return "assets/sunny.json";
      default:
        return "assets/sunny.json";
    }
  }

  @override
  void initState() {
    super.initState();
    // Initializing WeatherService with the provided apiKey
    _weatherService = WeatherService(apiKey);
    //fecth weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(
              _weather?.cityName ?? "", //show empty text upon loading city
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 50,
              ),
            ),
            const SizedBox(
              height: 60,
            ),

            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            //temperature
            const SizedBox(
              height: 25,
            ),
            Text(
              '${_weather?.temperature} °C',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 30,
              ),
            ),

            //weather condition
            Text(
              _weather?.mainCondition ?? "",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
