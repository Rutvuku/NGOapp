import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ngo_app/screens/onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5),
            ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Onboarding())));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset('assets/lottie/Animation - 1697216425685.json',fit: BoxFit.fill),
    );
  }
}
