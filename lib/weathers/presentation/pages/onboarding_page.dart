import 'package:flutter/material.dart';
import 'package:mobile_assesment/weathers/presentation/pages/homepage.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 40),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFF3C2DB9), Color(0xFF211772)])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Image.asset('images/cloud.png'),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              'Weather',
              style: TextStyle(
                  fontSize: 44,
                  color: Color(0xFFFFBA25),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Forecast App.',
              style: TextStyle(color: Colors.white, fontSize: 36),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, top: 20),
              child: Text(
                'It\'s the newest weather app. It has a bunch of features and that includes most of the ones that every weather app has.',
                style: TextStyle(color: Colors.white),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 60, left: 60),
                width: 220,
                height: 50,
                child: Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Color(0xFFFFBA25),
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
