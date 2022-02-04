import 'package:chattin/Network/network_dio.dart';
import 'package:chattin/Registration/otp_success.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class otpScreen extends StatefulWidget {
  const otpScreen({Key? key}) : super(key: key);

  @override
  _otpScreenState createState() => _otpScreenState();
}

class _otpScreenState extends State<otpScreen> {    
  NetworkRepository nw = NetworkRepository();
  String? get_email;
  String get_otp = '';
  String get_username = '';
  String get_password = '';
  String get_contactNo = '';
  bool _isEnable = false;
  
  @override
  void initState() {
    get();
    super.initState();
  }

  get()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    get_email = sharedPreferences.getString("email").toString();
  }

  reSendOTP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    dynamic resendOTP = await nw.httpPost(
      'User/sendotp',
      {
        'email': get_email,
      },
    );
    Map data = {
      'email': sharedPreferences.getString("email").toString(),
    };
    print('\x1b[95m ----$data');
    if (resendOTP != null &&
        (resendOTP['statusCode'] == 200 || resendOTP['statusCode'] == '200')) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => otpScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(resendOTP['message'].toString()),
        action: SnackBarAction(
          label: '',
          textColor: Colors.white,
          onPressed: () {},
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: Colors.blue,
      ));
    }
  }

  verify_otp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    get_username = sharedPreferences.getString("userName").toString();
    get_contactNo = sharedPreferences.getString("contactNo").toString();
    get_password = sharedPreferences.getString("password").toString();
    //print(get_otp);
    dynamic response = await nw.httpPost(
      'User/verifyOTP',
      {
        'email': get_email,
        'code': get_otp,
      },
    );
    Map get_otp_data = {
      'email': get_email,
      'code': get_otp,
    };
    print('\x1b[95m ----$get_otp_data');
    if (response != null &&
        (response['statusCode'] == 200 || response['statusCode'] == '200')) {
      dynamic do_register = await nw.httpPost(
        'User/registration',
        {
          'username': get_username,
          'contactNo': get_contactNo,
          'email': get_email,
          'password': get_password,
        },
      );
      Map registrationData = {
        'username': get_username,
        'contactNo': get_contactNo,
        'email': get_email,
        'password': get_password,
      };
      print('\x1b[96m ----$registrationData');
      if (do_register != null &&
          (do_register['statusCode'] == 200 ||
              do_register['statusCode'] == '200')) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => otpSucceed()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(do_register['message'].toString()),
          action: SnackBarAction(
            label: '',
            textColor: Colors.white,
            onPressed: () {},
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.blue,
        ));
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("otp verification",
            style: TextStyle(
              color: Colors.white,
            )),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "We sent code $get_email to kindly check your mail.",
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "This code will expired in ",
              ),
              TweenAnimationBuilder(
                tween: Tween(begin: 60.0, end: 0.0),
                duration: Duration(seconds: 60),
                builder: (_, dynamic value, child) => Text(
                  "00:${value.toInt()}",
                  style: TextStyle(color: Colors.blue),
                ),
                onEnd: (){
                  setState(() {
                    _isEnable = true;
                  });
                },
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
                  get_otp = pin;
                },
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 20, bottom: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    verify_otp();
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Visibility(
                visible: _isEnable,
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: () {
                      reSendOTP();
                    },
                    child: new Ink(
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                            color: Color(0xFF42A5F5)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
