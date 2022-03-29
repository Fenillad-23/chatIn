import 'package:chattin/HomeScreen/UserProfileMain/scanQR.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode_widget/barcode_widget.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({Key? key}) : super(key: key);

  @override
  State<GenerateQRCode> createState() => _GenerateQRCodeState();
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  bool? darkthemeState;
  String? username;
  @override
  void initState() {
    super.initState();
    setThemeState();
    setState(() {});
  }

  @override
  void setThemeState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    darkthemeState = sharedPreferences.getBool("lightTheme");
    username = sharedPreferences.getString("username");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "QR Code",
          style: TextStyle(
              color: darkthemeState == true ? Colors.white : Colors.black),
        ),
        backgroundColor:
            darkthemeState == true ? Colors.black54 : Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back,
              color: darkthemeState == true ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // backgroundColor:darkthemeState == true ? Colors.black54 : Colors.transparent, Colors.white, //Color.fromARGB(255, 221, 219, 219),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width / 1.3,
              child: Card(
                elevation: 8,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 163, 159, 159)),
                ),
                color: Colors.white,
                shadowColor: Color.fromRGBO(255, 255, 255, 1),
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: BarcodeWidget(
                          barcode: Barcode.qrCode(
                            errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                          ),
                          data: '$username',
                          width: 200,
                          height: 200,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '$username',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 8,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width / 1.3,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScanQRCode()));
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(builder: (context) => ScanQRCode()),
                //     (route) => false);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.5),
                ),
              ),
              child: Text(
                "Scan QR Code",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
