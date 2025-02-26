import 'dart:ui';

import 'package:flutter/material.dart';

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
                  HourlyForcastCard(),
                  HourlyForcastCard(),
                  HourlyForcastCard(),
                  HourlyForcastCard(),
                  HourlyForcastCard(),
                  HourlyForcastCard()
                ],
              ),
            ),

            const SizedBox(height: 20),

            // weather additional detail card
            Text(
              'Additional Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            Placeholder(fallbackHeight: 50),
          ],
        ),
      ),
    );
  }
}

class HourlyForcastCard extends StatelessWidget {
  const HourlyForcastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: const Color.fromARGB(50, 255, 255, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'time',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            Icon(Icons.cloud, size: 40),
            Text(
              'tempe',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
