import 'dart:ffi';

import 'package:finder_app/pages/homePage.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Center(
          child: Column(
            children: [
              Image(
                  image:
                      const AssetImage('assets/images/welcomeBackground.webp'),
                  width: MediaQuery.of(context).size.width),
              const Text("Welcome to Finder App",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 20),
              const Text(
                  "Using this app you can find Restaurants to Hospitals, Gas Stations to ATMs, Store to Shopping Malls, and many more. With this app, you can not only find the easiest route to your desired place, but also other information such as contact details and others.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black)),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text("Find your place",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
