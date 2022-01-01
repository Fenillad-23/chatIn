import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class otpSucceed extends StatefulWidget {
  const otpSucceed({Key? key}) : super(key: key);

  @override
  _otpSucceedState createState() => _otpSucceedState();
}

class _otpSucceedState extends State<otpSucceed> {
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
                Lottie.asset(
                  'assets/json/done.json',
                  width: 150,
                ),
                SizedBox(
                  height: 40,
                ),
                const Text(
                  "Congratulations",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 38.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  "Welcome to Home page",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
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
                          "Done",
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
