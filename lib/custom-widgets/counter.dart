import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int initialvalue = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      height: 40,
      width: MediaQuery.of(context).size.width / 1.8,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black45)),
      child: initialvalue == 0
          ? Container(
              width: MediaQuery.of(context).size.width / 3.8,
              child:
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          TextButton(
                              child: Text(
                                "ADD",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              ),
                              onPressed: () {
                                setState(() {
                                  initialvalue++;
                                });
                              },
                )
              ]),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: TextButton.styleFrom(primary: Colors.green),
                    onPressed: () {
                      setState(() {
                        if (initialvalue > 0) {
                          initialvalue--;
                        } else {
                          initialvalue = 0;
                        }
                      });
                    },
                    // child: Text(
                    //   "-",
                    //   style: TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black45),
                    // )
                   child: Icon(Icons.remove, color: Colors.black45,),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    initialvalue.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                  ),
                  style: TextButton.styleFrom(primary: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (initialvalue < 1000) {
                        initialvalue++;
                      } else {
                        initialvalue = 10;
                      }
                    });
                  },
                  // child: Text(
                  //   "+",
                  //   style: TextStyle(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.black45),
                  // ),
                  child: Icon(Icons.add, color: Colors.black45,),
                  style: TextButton.styleFrom(primary: Colors.white),
                )
              ],
            ),
    );
  }
}
