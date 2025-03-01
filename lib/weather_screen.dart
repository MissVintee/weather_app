import 'dart:ui';
import 'package:flutter/material.dart';
import 'hourly_forecast_item.dart';
import 'additional_info.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
      body: Padding(
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
                            '25°C',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Icon(Icons.cloud, size: 50),
                          const SizedBox(height: 3),
                          Text(
                            'Rainy',
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
              'Weather Forecast',
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
                  value: '5 km/h',
                  icon: Icons.air,
                ),
                AdditionalInfoItem(
                  title: 'Humidity',
                  value: '80%',
                  icon: Icons.water_drop_outlined,
                ),
                AdditionalInfoItem(
                  title: 'Pressure',
                  value: '1000 hPa',
                  icon: Icons.speed,
                ),
                AdditionalInfoItem(title: 'Temperature', value: '25°C', icon: Icons.thermostat),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
