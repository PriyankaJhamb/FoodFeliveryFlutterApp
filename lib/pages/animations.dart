import 'dart:math';

import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {

  Color color=Colors.green;
  double borderRadius=1;
  double margin=1;
  // Acting as a Constructor
  //execute before build method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  void updateAttributes(){
    color= Color(0xFFFFFFFFF & Random().nextInt(0xFFFFFFFF));
    borderRadius=Random().nextDouble() * 64;
    margin=Random().nextDouble()* 64;
  }
  void animateContainer(){
    setState(() {
      updateAttributes();
    });
  }
  //Acting as a destructor
  //when this widget will be deleted from memory
  // i.e. When we pop up the widget from the UI
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("food delivery"),
      ),
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              width: 256,
              height: 256,
              duration: Duration(milliseconds: 1000),
              margin: EdgeInsets.all(margin),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(borderRadius)
              ),
            ),
            SizedBox(
              height: 256,
            ),
            TextButton(
                onPressed: (){
                  animateContainer();
                },
                child: Text("Animate Container"))

          ],
        ),
      ),
    );
  }
}
