import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Credit Card Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Awesome Credit Card Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                const Text(
                  "Verification Code",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 38.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  "Please enter the verification code send to ",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 35,
                ),
                OTPTextField(
                  length: 4,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 60,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 15,
                  style: TextStyle(fontSize: 17),
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                  },
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 20, bottom: 20.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Ink(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Sign In",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
