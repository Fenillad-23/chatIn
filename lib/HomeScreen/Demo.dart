import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
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
                      // Respond to button press
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.5),
                      ),
                    ),
                    child: Text(
                      'Follow',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                    color: Colors.white,
                    height:200,
                    width: 200,
                    child: Row(
                      children: [
                        Container(
                          //color: Colors.blue,
                          child: Column(
                            children: [
                              Text(
                                "Column1",
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ),
                        Container(
                          //color: Colors.yellow,
                          child: Column(
                            children: [
                              Text(
                                "Column2",
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ),
                        Container(
                          //color: Colors.green,
                          child: Column(
                            children: [
                              Text(
                                "Column3",
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ])),
      ),
    );
  }
}
