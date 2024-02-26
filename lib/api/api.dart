import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/weather_model.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<WeatherModel?> fetchWeather() async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=27.7089543&lon=85.284933&appid=20177d1fa45e56e2e1a58712faa338a7"));
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
    return null;
  }
}
