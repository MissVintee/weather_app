import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'hourly_forecast_item.dart';
import 'additional_info.dart';
import 'package:http/http.dart' as http;
import 'secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getWeatherData() async {
    // get weather data from API
    try {
      String cityName = 'Raipur';
      final result = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIkey',
        ),
      );

      final data = jsonDecode(result.body);
      if (data['cod'] != '200') {
        throw 'An Unexpected Error Occurred';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
        ],
      ),
      //-------- main card --------
      body: FutureBuilder(
        future: getWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(fontSize: 24),
              ),
            );
          }

          final data = snapshot.data!;

          final currentWeatherData = data['list'][0];
          final currentTemp = currentWeatherData['main']['temp'];
          final weather = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 160,
                  child: Card(
                    color: const Color.fromARGB(50, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    elevation: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 8),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp K',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Icon(
                                weather == 'Clouds' || weather == 'Rain'? Icons.cloud: Icons.clear, size: 50),
                              const SizedBox(height: 3),
                              Text(
                                weather,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // weather detail forecast card
                Text(
                  'Hourly Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),

                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HourlyForcastCard(
                        time: '00:00',
                        icon: Icons.cloud,
                        temperature: '25°C',
                      ),
                      HourlyForcastCard(
                        time: '03:00',
                        icon: Icons.cloud,
                        temperature: '26°C',
                      ),
                      HourlyForcastCard(
                        time: '06:00',
                        icon: Icons.cloud,
                        temperature: '27°C',
                      ),
                      HourlyForcastCard(
                        time: '09:00',
                        icon: Icons.cloud,
                        temperature: '28°C',
                      ),
                      HourlyForcastCard(
                        time: '12:00',
                        icon: Icons.sunny,
                        temperature: '29°C',
                      ),
                      HourlyForcastCard(
                        time: '15:00',
                        icon: Icons.sunny,
                        temperature: '30°C',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // weather additional detail card
                Text(
                  'Additional Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      title: 'Wind Speed',
                      value: '$currentWindSpeed km/h',
                      icon: Icons.air,
                    ),
                    AdditionalInfoItem(
                      title: 'Humidity',
                      value: '$currentHumidity',
                      icon: Icons.water_drop_outlined,
                    ),
                    AdditionalInfoItem(
                      title: 'Pressure',
                      value: '$currentPressure hPa',
                      icon: Icons.speed,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
