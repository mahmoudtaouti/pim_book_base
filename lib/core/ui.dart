import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pim_book/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

  }

  Future<void> init() async {
    Future.delayed(Duration(seconds: 2)).then((value) => PIMBook());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/splash_background.jpg',
            height: Get.height,
            width: Get.width,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/pim_logo.png', height: 120, width: 120),
              SizedBox(height: 31,),
              Text('PIM Book', style: TextStyle(height: 26)),
            ],
          ),
        ],
      ),
    );
  }
}
