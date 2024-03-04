import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  int index = 0;

  final _weatherSubject = BehaviorSubject<String>.seeded('Fetching');

  late StreamSubscription<String> _weatherSubscription;

  @override
  void initState() {
    super.initState();
    _startFetchingWeather();
  }

  @override
  void dispose() {
    _weatherSubject.close();
    _weatherSubscription.cancel();
    super.dispose();
  }

  void _startFetchingWeather() {
    _weatherSubscription = _fetchWeather().listen((temperature) {
      _weatherSubject.add(temperature);
    });
  }

  Stream<String> _fetchWeather() async* {
    final random = Random();
    // Simulated weather data fetching
    while (true) {
      await Future.delayed(const Duration(seconds: 3));
      final temperature = random.nextInt(41); // Random integer between 0 and 40
      yield '$temperature°C'; //Simulated temperature data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Package Implementation"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: phoneNumberController,
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () => _makePhoneCall(phoneNumberController.text),
            child: const Icon(Icons.call),
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () => _makeSms(phoneNumberController.text),
            child: const Icon(Icons.message),
          ),
          StreamBuilder<String>(
            stream: _weatherSubject,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data ?? "",
                  style: const TextStyle(fontSize: 24),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          MaterialButton(
            onPressed: () {
              _startFetchingWeather();
            },
            color: Colors.pink,
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _makeSms(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
