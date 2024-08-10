import 'package:animalwelfare/widgets/animatelogo.dart';
import 'package:animalwelfare/widgets/custompageroute.dart';
import 'package:animalwelfare/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  stateSplashScreen createState() => stateSplashScreen();
}

class stateSplashScreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).push(
        Custompageroute(child: const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedLogo(
              child: Image.asset(
                "assets/images/Animal_Welfare-1logo.png",
                height: 200,
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
