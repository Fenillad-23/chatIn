import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            color: new Color(0xFFECEFF1),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 110,
                    width: 110,
                    //color:Colors.green,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset('assets/images/user.jpeg',
                              width: 86, height: 86, fit: BoxFit.contain),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Container(
                      width: 195,
                      height: 60,
                      //  color: Colors.yellow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Vaidehi047",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          Container(
                              padding: EdgeInsets.fromLTRB(2, 5, 0, 0),
                              child: Text("Vaidehi Kheni",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 12))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  height: 57,
                  width: 92,
                  //color: Colors.deepOrange,
                  child: OutlinedButton.icon(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.5),
                          ),
                          side: BorderSide(
                            width: 2.0,
                            color: Colors.blue,
                            style: BorderStyle.solid,
                          )),
                      icon: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Icon(Icons.chat_bubble_outline,
                              size: 28, color: Colors.black87)),
                      label: Text("")),
                ),
                Container(
                  height: 57,
                  width: 208,
                  //color: Colors.deepPurple,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (index == 0) {
                          index = 1;
                        } else if (index == 1) {
                          index = 0;
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.5),
                      ),
                      side: BorderSide(
                        width: 2.0,
                        color: Colors.blue,
                      ),
                      primary: index == 1 ? new Color(0xFFECEFF1) : Colors.blue,
                    ),
                    child: Text(
                      index == 1 ? 'Following' : 'Follow',
                      style: TextStyle(
                          fontSize: 18,
                          color: index == 1 ? Colors.black : Colors.white),
                    ),
                  ),
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [],
                    ),
                  ),
                ],
              ),
            ])),
      ),
    );
  }
}
