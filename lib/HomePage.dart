import 'package:flutter/material.dart';

import 'package:rpi_gpio/rpi_gpio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                angle: 1.57079,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    angle: 0,
                  ),
                  CustomButton(
                    iconData: Icons.stop_sharp,
                  ),
                  CustomButton(
                    angle: 3.142,
                  ),
                ],
              ),
              CustomButton(
                angle: 4.7123,
              ),
            ],
          )),
    );
  }
}

class CustomButton extends StatefulWidget {
  final double angle;
  final IconData iconData;

  CustomButton({
    this.angle = 0,
    this.iconData = Icons.arrow_back,
  });
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        forward();
        onPressed();
      },
      child: Transform.rotate(
        angle: widget.angle,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
          margin: EdgeInsets.all(10),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: pressed ? Colors.lime : Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            widget.iconData,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void onPressed() {
    setState(() {
      pressed = true;
    });
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        pressed = false;
      });
    });
  }

  Future forward({Duration blink}) async {
    blink ??= const Duration(milliseconds: 500);
    final gpio = new RpiGpio();
    final led = gpio.output(5);
    for (int count = 0; count < 1000; ++count) {
      led.value = true;
      await new Future.delayed(blink);
      led.value = false;
      await new Future.delayed(blink);
    }
  }
}
