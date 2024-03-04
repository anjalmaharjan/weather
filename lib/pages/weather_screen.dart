import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';

import '../api/api.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  WeatherModel? model;
  final Api _api = Api();

  void getData() async {
    model = await _api.fetchWeather();
  }

  late AnimationController animationController;
  late Animation<double> sizeAnimation;
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();
    getData();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    colorAnimation = ColorTween(
            begin: const Color.fromARGB(255, 255, 222, 59), end: Colors.blue)
        .animate(animationController);
    sizeAnimation =
        Tween<double>(begin: 300.0, end: 200.0).animate(animationController);
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  double height = 50;
  double width = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              builder: (context, widget) {
                return Container(
                  width: sizeAnimation.value,
                  height: sizeAnimation.value,
                  color: colorAnimation.value,
                );
              },
              animation: sizeAnimation,
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: AnimatedContainer(
                height: height,
                width: width,
                color: Colors.yellow,
                duration: const Duration(seconds: 2),
                curve: Curves.easeIn,
              ),
            ),
            // AnimatedIcon(icon, progress: progress)
            const SizedBox(
              height: 100,
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  height = 100;
                  width = 100;
                });
              },
              color: Colors.blue,
              child: const Text("Animate Me"),
            ),

            Text(model?.name ?? ""),
            // Form(
            //   key: formKey,
            //   child: Column(
            //     children: [
            //       const SizedBox(
            //         height: 100,
            //       ),
            //       TextFormField(
            //         controller: userNameController,
            //         validator: (value) {
            //           if (value!.isEmpty) {
            //             return "User name cannot be empty";
            //           } else if (value.length < 5) {
            //             return "User name length should be greater than 5";
            //           }

            //           return null;
            //         },
            //         decoration: const InputDecoration(
            //           label: Text("username"),
            //         ),
            //       ),
            //       const SizedBox(
            //         height: 40,
            //       ),
            //       TextFormField(
            //         obscureText: true,
            //         controller: passwordController,
            //         decoration: const InputDecoration(
            //           label: Text("password"),
            //         ),
            //         validator: (value) {
            //           if (value!.isEmpty) {
            //             return "Password cannot be empty";
            //           } else {
            //             return null;
            //           }
            //         },
            //       ),
            //       const SizedBox(
            //         height: 40,
            //       ),
            //       MaterialButton(
            //         onPressed: () {
            //           // if (formKey.currentState!.validate()) {
            //           //   Navigator.push(context, route);
            //           // }

            //           // if (formKey.currentState!.validate()) {

            //           //   // ScaffoldMessenger.of(context).showSnackBar(
            //           //   //   const SnackBar(
            //           //   //     content: Text("Validation Incomplete"),
            //           //   //     backgroundColor: Colors.red,
            //           //   //   ),
            //           //   // );

            //           // }
            //         },
            //         color: Colors.blue,
            //         child: const Text("Sign in"),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
