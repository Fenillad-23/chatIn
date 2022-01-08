import 'package:chattin/Network/network_dio.dart';
import 'package:chattin/Registration/otp_success.dart';
import 'package:chattin/validation/validation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class change_password extends StatefulWidget {
  const change_password({Key? key}) : super(key: key);

  @override
  _change_passwordState createState() => _change_passwordState();
}

class _change_passwordState extends State<change_password> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmChangedPasswordController =
      TextEditingController();
  NetworkRepository nw = NetworkRepository();
  bool _isObscure = true;
  bool obscure = true;

  check_password() async {
    dynamic reset_password = '';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (_formKey.currentState!.validate()) {
      if (passwordController.text == confirmChangedPasswordController.text) {
        reset_password = await nw.httpPatch('User/changePassword', {
          'email': sharedPreferences.getString("VerifyEmail").toString(),
          'password': passwordController.text.toString(),
        });
        Map Data = {
          'email': sharedPreferences.getString("VerifyEmail").toString(),
          'password': passwordController.text.toString(),
        };
        print(Data);
        sharedPreferences.setString(
            "password", passwordController.text.toString());
        if (reset_password != null &&
            (reset_password['statusCode'] == 200 ||
                reset_password['statusCode'] == '200')) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => otpSucceed()));
          // reSendOTP();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              reset_password['message'].toString(),
            ),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(reset_password['message'].toString()),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Reset Password',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
                        "Please set your new password and login in ChatIn App.",
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
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        labelText: 'Change Password',
                        hintText: 'Enter your new password',
                      ),
                      validator: (value) => Validators.passwordValidator(
                          value!.trim(), "Password", 8),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      obscureText: obscure,
                      controller: confirmChangedPasswordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.security_sharp),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                        ),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your password',
                      ),
                      validator: (value) => Validators.passwordValidator(
                          value!.trim(), "Confirm Password", 8),
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
                        check_password();
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
