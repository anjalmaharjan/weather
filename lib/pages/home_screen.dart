import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 400) {
          return Row(
            children: [
              Flexible(
                child: Container(
                  color: Colors.red,
                  width: deviceWidth * 0.8,
                ),
              ),
              Container(
                color: Colors.pink,
                width: deviceWidth * 0.3,
              ),
              Container(
                color: Colors.yellow,
                width: deviceWidth * 0.2,
              ),
            ],
          );
        
        } else {
          return Column(
            children: [
              Flexible(
                child: Container(
                  color: Colors.red,
                  height: 300,
                ),
              ),
              Container(
                color: Colors.pink,
                height: 200,
              ),
              Container(
                color: Colors.yellow,
                height: 100,
              ),
            ],
          );
        }
      }),
    );
  }
}
