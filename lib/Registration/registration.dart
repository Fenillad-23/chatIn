import 'package:chattin/Registration/otp.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Login/login.dart';
import '../Network/network_dio.dart';
import '../validation/validation.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  int activeStep = 0;
  int dotCount = 2;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  NetworkRepository nw = NetworkRepository();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool obscure = true;

  verifyEmail() async {
    dynamic verifyEmail = await nw.httpPost('User/checkemail', {
      'email': emailController.text.toString(),
    });
    Map checkEmailData = {
      'email': emailController.text.toString(),
    };
    print('\x1b[96m ----$checkEmailData');
    if (verifyEmail != null &&
        (verifyEmail['statusCode'] == 200 ||
            verifyEmail['statusCode'] == '200')) {
      sendOTP();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(verifyEmail['message'].toString()),
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

  verifyUser() async {
    dynamic verifyUser = await nw.httpPost('User/checkusername', {
      'username': userNameController.text.toString(),
    });
    Map checkUserData = {
      'username': userNameController.text.toString(),
    };
    print('\x1b[97m ----$checkUserData');
    if (verifyUser != null &&
        (verifyUser['statusCode'] == 200 ||
            verifyUser['statusCode'] == '200')) {
      verifyEmail();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(verifyUser['message'].toString()),
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

  sendOTP() async {
    dynamic response = await nw.httpPost(
      'User/sendotp',
      {
        'email': emailController.text.toString(),
      },
    );
    Map data = {
      'email': emailController.text.toString(),
    };
    print('\x1b[95m ----$data');
    if (response != null &&
        (response['statusCode'] == 200 || response['statusCode'] == '200')) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('email', emailController.text.toString());
      sharedPreferences.setString(
          'username', userNameController.text.toString());
      sharedPreferences.setString(
          'contactNo', contactNoController.text.toString());
      sharedPreferences.setString(
          'fullName', fullNameController.text.toString());
      sharedPreferences.setString(
          'password', passwordController.text.toString());
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => otpScreen()));
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
    }
  }

  validate() async {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text == confirmPasswordController.text) {
        verifyUser();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Password and confirm password are not match."),
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
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
                  height: 30,
                ),
                stepList(),
                SizedBox(
                  height: 20,
                ),
                DotStepper(
                  dotCount: dotCount,
                  dotRadius: 6,
                  activeStep: activeStep,
                  shape: Shape.circle,
                  spacing: 10,
                  indicator: Indicator.shift,
                  onDotTapped: (tappedDotIndex) {
                    setState(() {
                      activeStep = tappedDotIndex;
                    });
                  },
                  fixedDotDecoration: FixedDotDecoration(
                    color: Colors.grey,
                  ),
                  indicatorDecoration: IndicatorDecoration(
                    color: Colors.blue,
                  ),
                  lineConnectorDecoration: LineConnectorDecoration(
                    color: Colors.black,
                    strokeWidth: 0,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 150,
                            child: previousButton(),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 150,
                            child: nextButton(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login())),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column stepList() {
    switch (activeStep) {
      case 0:
        return Column(
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
                  hintText: 'Enter user Name',
                ),
                validator: (value) =>
                    Validators.userNameValidator(value!.trim(), "user Name"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  labelText: 'Email',
                  hintText: 'Enter Your Email Address',
                ),
                validator: (value) =>
                    Validators.emailAddressValidator(value!.trim(), "email"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  labelText: 'Full Name',
                  hintText: 'Enter Your full Name',
                ),
                validator: (value) =>
                    Validators.userNameValidator(value!.trim(), "full Name"),
              ),
            ),
          ],
        );
      case 1:
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: contactNoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  labelText: 'Contact Number',
                  hintText: 'Enter Your Contact Number',
                ),
                validator: (value) =>
                    Validators.ContactNumberValidator(value!.trim(), "contact"),
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
                      _isObscure ? Icons.visibility : Icons.visibility_off,
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
                validator: (value) =>
                    Validators.passwordValidator(value!.trim(), "Password", 8),
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
                      obscure ? Icons.visibility : Icons.visibility_off,
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
          ],
        );
      default:
        return Column(
          children: [
            Container(
              height: 100,
              width: 100,
            )
          ],
        );
    }
  }

  /// Returns the next button widget.
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        if (activeStep == 1) {
          //print(userNameController);
          validate();
        } else if (activeStep < dotCount - 1) {
          setState(() {
            activeStep++;
          });
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.5),
        ),
      ),
      child: Text(
        "Next",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  /// Returns the previous button widget.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.5),
        ),
      ),
      child: Text(
        "Previous",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
