import 'package:chattin/Login/login.dart';
import 'package:chattin/Registration/otp_success.dart';
import 'package:chattin/Network/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:chattin/validation/validation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  NetworkRepository nw = NetworkRepository();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool obscure = true;
  registration() async {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text == confirmPasswordController.text) {
        dynamic response = await nw.httpPost(
          'User/registration',
          {
            'username': userNameController.text.toString(),
            'contactNo': contactNoController.text.toString(),
            'email': emailController.text.toString(),
            'password': passwordController.text.toString(),
          },
        );
        Map data = {
          'username': userNameController.text.toString(),
          'contactNo': contactNoController.text.toString(),
          'email': emailController.text.toString(),
          'password': passwordController.text.toString(),
        };
        print('\x1b[95m ----$data');
        if (response != null &&
            (response['statusCode'] == 200 ||
                response['statusCode'] == '200')) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString(
              'usename', response['data']['newUser']['username'].toString());

          sharedPreferences.setString(
              'password', response['data']['newUser']['password'].toString());
          sharedPreferences.setString(
              'contactNo', response['data']['newUser']['contactNo'].toString());
          sharedPreferences.setString(
              'email', response['data']['newUser']['email'].toString());
          // print('\x1b[95m Email : ${sharedPreferences.getString('email')}');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => otpSucceed(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              response['message'].toString(),
            ),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Password & ConfirmPassword Not Matched!'.toString(),
          ),
        ));
      }
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
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(85),
                    child: Image.asset(
                      'assets/images/logo_blue.png',
                      width: 85,
                      height: 85,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Register Account",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  const Text(
                    "Register your self by filling below information",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: userNameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            labelText: 'User Name',
                            hintText: 'Enter Your Name',
                          ),
                          validator: (value) => Validators.userNameValidator(
                              value!.trim(), "User Name"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            labelText: 'Email',
                            hintText: 'Enter Your Email Address',
                          ),
                          validator: (value) =>
                              Validators.emailAddressValidator(
                                  value!.trim(), "email"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: contactNoController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            labelText: 'Contact Number',
                            hintText: 'Enter Your Contact Number',
                          ),
                          validator: (value) =>
                              Validators.ContactNumberValidator(
                                  value!.trim(), "contact"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: _isObscure,
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
                          validator: (value) => Validators.passwordValidator(
                              value!.trim(), "Password", 8),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                          obscureText: obscure,
                          controller: confirmPasswordController,
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            registration();
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 330.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Sign Up",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login())),
                            child: Text(
                              "Already have an account?Sign in",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
