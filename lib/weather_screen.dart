import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late Future<Map<String, dynamic>> weather;
  
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
  void initState() {
    super.initState();
    weather = getWeatherData();
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
          IconButton(icon: const Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              weather = getWeatherData();
            });
          }),
        ],
      ),
      //-------- main card --------
      body: FutureBuilder(
        future: weather,
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
                                weather == 'Clouds' || weather == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 50,
                              ),
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

                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 0; i < 20; i++)
                //         HourlyForecastCard(
                //           time: data['list'][i + 1]['dt'].toString(),
                //           icon:
                //               data['list'][i + 1]['weather'][0]['main'] ==
                //                           'Clouds' ||
                //                       data['list'][i +
                //                               1]['weather'][0]['main'] ==
                //                           'Rain'
                //                   ? Icons.cloud
                //                   : Icons.sunny,
                //           temperature:
                //               data['list'][i + 1]['main']['temp'].toString(),
                //         ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      final hourlyForecast = data['list'][index + 1];
                      final time = DateTime.parse(hourlyForecast['dt_txt']);
                      return HourlyForecastCard(
                        time: DateFormat.j().format(
                          time,
                        ), //DateFormat('j').format(time) use either of them
                        icon:
                            hourlyForecast['weather'][0]['main'] == 'Clouds' ||
                                    hourlyForecast['weather'][0]['main'] ==
                                        'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                        temperature: hourlyForecast['main']['temp'].toString(),
                      );
                    },
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
