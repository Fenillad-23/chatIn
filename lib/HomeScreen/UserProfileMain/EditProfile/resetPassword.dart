import 'dart:async';

import 'package:chattin/HomeScreen/Home.dart';
import 'package:chattin/Network/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Login/Forget_Password/forget_password.dart';
import '../../../validation/validation.dart';

class resetPassword extends StatefulWidget {
  String? email;
  resetPassword({Key? key, this.email}) : super(key: key);

  @override
  State<resetPassword> createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController confirmChangedPasswordController =
      TextEditingController();
  bool _isObscure = true;
  bool obscure = true;
  NetworkRepository nw = NetworkRepository();

  redirect_to() async {
    Timer(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Home()), (route) => false);
    });
  }

  check_password() async {
    dynamic reset_password = '';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (_formKey.currentState!.validate()) {
      if (oldPasswordController.text ==
          sharedPreferences.getString('password')) {
        if (passwordController.text == confirmChangedPasswordController.text) {
          reset_password = await nw.httpPatch('User/changePassword', {
            'email': widget.email.toString(),
            'password': passwordController.text.toString(),
          });
          Map Data = {
            'email': widget.email.toString(),
            'password': passwordController.text.toString(),
          };
          print(Data);
          sharedPreferences.setString(
              "password", passwordController.text.toString());
          if (reset_password != null &&
              (reset_password['statusCode'] == 200 ||
                  reset_password['statusCode'] == '200')) {
            redirect_to();
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          height: 280,
                          width: MediaQuery.of(context).size.width,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Lottie.asset("assets/json/true.json",
                                    height: 150),
                                Text("Password is successfully changed.",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(reset_password['message'].toString()),
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
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Password and confirm password doesn't match."),
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Your old password is wrong."),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Change Password",
            style: TextStyle(
              color: Colors.black,
            )),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      controller: oldPasswordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        labelText: 'Old Password',
                        hintText: 'enter your old password',
                      ),
                    ),
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
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left:20.0),
                        child: GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPassword())),
                          // builder: (context) => otpScreen())),
                          child: Text(
                            "Forgot Password",textAlign: TextAlign.start,
                            style:
                                TextStyle(decoration: TextDecoration.underline,color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 0, bottom: 80),
                    child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        check_password();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.5),
                        ),
                      ),
                      child: Text(
                        "Change Password",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
