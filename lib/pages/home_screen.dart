import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? name;

  List nameList = [1, 1, 23, 3];

  void assignValue() {
    name = null;
  }

  void assignDate() {
    try {
      name = int.parse("Sanjeev"); // Format exception
      name = null;

      print(nameList[5]); // TypeError Exception
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    assignValue();
    assignDate();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 400) {
          return Row(
            children: [
              Container(
                color: Colors.red,
                width: deviceWidth * 0.8,
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
                  height: 1000,
                  child: const Text("Sanjeev"),
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
