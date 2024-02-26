import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';

import '../api/api.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  WeatherModel? model;
  final Api _api = Api();

  void getData() async {
    model = await _api.fetchWeather();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(model?.name ?? ""),
            Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    controller: userNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "User name cannot be empty";
                      } else if (value.length < 5) {
                        return "User name length should be greater than 5";
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("username"),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      label: Text("password"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  MaterialButton(
                    onPressed: () {
                      // if (formKey.currentState!.validate()) {
                      //   Navigator.push(context, route);
                      // }

                      // if (formKey.currentState!.validate()) {

                      //   // ScaffoldMessenger.of(context).showSnackBar(
                      //   //   const SnackBar(
                      //   //     content: Text("Validation Incomplete"),
                      //   //     backgroundColor: Colors.red,
                      //   //   ),
                      //   // );

                      // }
                    },
                    color: Colors.blue,
                    child: const Text("Sign in"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
