import 'package:chattin/Registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Login/login.dart';
import '../validation/validation.dart';

class signUp1 extends StatefulWidget {
  const signUp1({Key? key}) : super(key: key);

  @override
  State<signUp1> createState() => _signUp1State();
}

class _signUp1State extends State<signUp1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isObscure = true;
  bool obscure = true;

  validate() async{
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(children: [
                            SizedBox(
                              height: 100,
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
                            const Text(
                              "Register your self by filling below information",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(children: [
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
                                  validator: (value) =>
                                      Validators.userNameValidator(
                                          value!.trim(), "User Name"),
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
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscure
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));
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
                                "Continue",
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
                            onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login())),
                            child: Text(
                              "Already have an account? Sign in",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16,
                                  color: Colors.blue[300]),
                            ),
                          )
                        ],
                      ),
                            ])
                          ]))
                    ]))));
  }
}
