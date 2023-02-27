import 'dart:async';
import 'package:covidapp/worldstats.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  late final AnimationController _controller= AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,)..repeat();

  @override
  void initState() {
    super.initState();
    
  Timer(const Duration(seconds: 5), ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> const WorldStats())));
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller, 
              builder: (BuildContext context, child){
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                  );   
              },
              child: Container(
                height: 200,
                width: 200,
                child: const Center(
                  child: Image(image: AssetImage('assets/virusimg.png'))),),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text('COVID-19 \n STATISTICS', textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.teal, fontSize: 25,fontFamily: 'helvatica',  fontWeight: FontWeight.bold),),
              )

          ],
        )),
    );
  }
}