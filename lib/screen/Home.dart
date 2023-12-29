import 'package:flutter/material.dart';
import 'package:flutter_fitness_application/screen/Dashboard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController _pageController;

  late AnimationController rippleController;
  late AnimationController scaleController;

  late Animation<double> rippleAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    rippleController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    scaleController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Dashboard()));
            }
          });

    rippleAnimation =
        Tween<double>(begin: 80.0, end: 90.0).animate(rippleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              rippleController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              rippleController.forward();
            }
          });

    scaleAnimation =
        Tween<double>(begin: 1.0, end: 30.0).animate(scaleController);

    rippleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          makePage(image: 'assets/images/two.jpg'),
          makePage(image: 'assets/images/one.jpg'),
          makePage(image: 'assets/images/three.jpg'),
        ],
      ),
    );
  }

  Widget makePage({image}) {
    return Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.black.withOpacity(.3),
                Colors.black.withOpacity(.2),
              ])),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      'Good day\nhealth body',
                      style: TextStyle(
                          color: Color.fromARGB(255, 200, 224, 229),
                          fontSize: 45,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'With this app you can try different activities\nand choose what is more enjoyable for you.',
                      style: TextStyle(
                          color: Color.fromARGB(255, 185, 202, 206),
                          fontSize: 18,
                          height: 1.4,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedBuilder(
                    animation: rippleAnimation,
                    builder: (context, child) => Container(
                      width: rippleAnimation.value,
                      height: rippleAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(.4)),
                        child: InkWell(
                          onTap: () {
                            scaleController.forward();
                          },
                          child: AnimatedBuilder(
                            animation: scaleAnimation,
                            builder: (context, child) => Transform.scale(
                              scale: scaleAnimation.value,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: scaleController.status ==
                                            AnimationStatus.forward ||
                                        scaleController.status ==
                                            AnimationStatus.completed
                                    ? null
                                    : Center(
                                        child: Icon(
                                        Icons.fingerprint,
                                        size: 40,
                                      )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
