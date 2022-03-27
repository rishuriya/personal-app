import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:personal_project/Home.dart';
import 'package:personal_project/expanse/Expanse_home.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    _navigateToHome();
  }

  _navigateToHome()async{
    await Future.delayed(const Duration(milliseconds: 5000));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Expanse()
      ));
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child:Image.asset(
                'images/splash_1.png',
                height: 500,
                width: 300,
                alignment: Alignment.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child:SpinKitFadingCube(
                color: Colors.yellow.shade100,
                size: 30.0,
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.pinkAccent,
    );
  }
}
