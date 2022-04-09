import 'package:chattin/Network/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:chattin/validation/validation.dart';
import 'package:chattin/Login/login.dart';
import 'package:chattin/Login/Forget_Password/code_verification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  NetworkRepository nw = NetworkRepository();
  forget_password() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('VerifyEmail', emailController.text.toString());
    if (_formKey.currentState!.validate()) {
      dynamic verify_mail = await nw.httpPost(
          'User/checkemail', {'email': emailController.text.toString().trim()});
      Map Email = {
        'email': emailController.text.toString().trim(),
      };
      print('VerifyEmail:$Email');
      // print(verify_mail['statusCode']);
      if (verify_mail != null &&
          (verify_mail['statusCode'] == 500 ||
              verify_mail['statusCode'] == '500')) {
        reSendOTP();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid Email!! Please register email First"),
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
  }

  reSendOTP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dynamic resendOTP = await nw.httpPost(
      'User/sendotp',
      {
        'email': sharedPreferences.getString("VerifyEmail").toString(),
      },
    );
    Map data = {
      'email': sharedPreferences.getString("VerifyEmail").toString(),
    };
    print('\x1b[95m ----$data');
    if (resendOTP != null &&
        (resendOTP['statusCode'] == 200 || resendOTP['statusCode'] == '200')) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => codeVerification()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Forget Password",
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/logo_blue.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 0, bottom: 0),
                      child: Text(
                        "Enter your email,you will receive a verification code on it.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 0, bottom: 0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide:
                              BorderSide(color: Colors.red, width: 50.0),
                        ),
                        labelText: 'Email',
                        hintText: 'Enter Your Email Address',
                      ),
                      validator: (value) => Validators.emailAddressValidator(
                          value!.trim(), "email"),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 0, bottom: 80),
                    child: ElevatedButton(
                      onPressed: () {
                        forget_password();
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 330.0, minHeight: 50.0),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
