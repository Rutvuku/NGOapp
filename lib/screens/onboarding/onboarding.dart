import 'package:flutter/material.dart';
import 'package:ngo_app/screens/login_user/login_user.dart';
import 'package:ngo_app/screens/onboarding/page_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login_ngo/login_ngo.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: const [
              Page1(
                "Earn for every Referal ",
                "assets/images/boba-wealth.png",
                Colors.amberAccent,
              ),
              Page1(
                "Send Money Fast",
                "assets/images/urban-saving-money.png",
                Colors.amberAccent,
              ),
              Page1(
                "Over 50 Countries",
                "assets/images/martina-guy-sends-a-message-from-phone.png",
                Colors.amberAccent,
              ),
            ],
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginUser()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      fixedSize: const Size(250.0, 40.0),
                    ),
                    child: const Text(
                      "Login as user",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginNGO()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      fixedSize: const Size(250.0, 40.0),
                    ),
                    child: const Text(
                      "Login as ngo",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
