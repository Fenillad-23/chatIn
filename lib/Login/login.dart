import 'package:chattin/Network/network_dio.dart';
//import 'package:chattin/Registration/otp.dart';
import 'package:chattin/Registration/registration.dart';
import 'package:chattin/Registration/otp_success.dart';
import 'package:chattin/Login/Forget_Password/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _value = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  NetworkRepository nw = NetworkRepository();
  bool _isObscure = true;
  login() async {
    if (_formKey.currentState!.validate()) {
      dynamic response = await nw.httpPost(
        'User/login',
        {
          'username': userNameController.text.toString(),
          'password': passwordController.text.toString(),
        },
      );
      if (response != null &&
          (response['statusCode'] == 200 || response['statusCode'] == '200')) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool('isRememberMe', _value);
        // sharedPreferences.setString(
        //     'email', response['data']['email'].toString());
        // sharedPreferences.setString(
        //     'password', passwordController.text.toString());
        // print('\x1b[95m Email : ${sharedPreferences.getString('email')}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => otpSucceed(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response['message'].toString()),
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
        // showDialog<String>(
        //   context: context,
        //   builder: (BuildContext context) => AlertDialog(
        //     title: const Text('Something Went Wrong'),
        //     content: Text(response['message'].toString()),

        //     actions: <Widget>[
        //       TextButton(
        //         onPressed: () => Navigator.pop(context, 'Cancel'),
        //         child: const Text('Cancel'),
        //       ),
        //       TextButton(
        //         onPressed: () => Navigator.pop(context, 'OK'),
        //         child: const Text('OK'),
        //       ),
        //     ],
        //   ),
        // );
      }
      print('\x1b[93m --- $response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
                padding: EdgeInsets.all(15),
                child: Column(children: [
                  SizedBox(
                    height: 50,
                  ),
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
                    height: 30,
                  ),
                  const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Welcome back! Login with your credentials",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_sharp),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        labelText: 'User Name',
                        hintText: 'Enter Your Name',
                      ),
                      controller: userNameController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
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
                          labelText: 'Password',
                          hintText: 'Enter your password',
                        ),
                        controller: passwordController),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _value,
                        onChanged: (newValue) {
                          setState(() {
                            _value = newValue!;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      Text("Remember me"),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPassword())),
                          // builder: (context) => otpScreen())),
                          child: Text(
                            "Forgot Password",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        login();
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
                            "Sign In",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Registration())),
                          child: Text(
                            "Don't have an account? sign up",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  )
                ]))
          ]),
        ),
      ),
    );
  }
}
