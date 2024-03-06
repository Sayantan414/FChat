import 'package:f_chat/api/apis.dart';
import 'package:f_chat/main.dart';
import 'package:f_chat/screens/home_screen.dart';
import 'package:f_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(systemNavigationBarColor: Colors.white));

      if (APIs.auth.currentUser != null) {
        print('\nUser: ${APIs.auth.currentUser}');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Welcome to F**Chat",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            // duration: const Duration(seconds: 1),
            child: Image.asset('images/icon.png'),
          ),
          Positioned(
              bottom: mq.height * .15,
              // left: mq.width * .05,
              width: mq.width,
              child: const Text(
                'DESIGNED & DEVELOPED BY SS ❣️',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              )),
        ],
      ),
    );
  }
}
