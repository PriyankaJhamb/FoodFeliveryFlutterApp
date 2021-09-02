import 'package:flutter/material.dart';

Route getAnimatedRoute(Widget page){
  //pagebuilder shall return the page on which we wish to navigate
  return PageRouteBuilder<SlideTransition>(
      pageBuilder: (context, animation, secondaryAnimation){
        return page;
      },
    transitionsBuilder: (context,animation,secondaryAnimation, child){
        var tween=Tween(begin: Offset(0.0, 1.0), end: Offset.zero);
        var curveTween=CurveTween(
            curve: Curves.ease
        );
        return SlideTransition(
            position: animation.drive(curveTween).drive(tween),
          child: child,
        );
    }
  );
}

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: (){},
          child: Text("Welcome"),
        ),
      ),
    );
  }
}
