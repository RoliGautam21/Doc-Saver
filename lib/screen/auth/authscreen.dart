import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/colors.dart';
import '../../widget/gradientBack.dart';
import '../../widget/mywidget.dart';
import '../../logic/k/provider/mprovider.dart';
import 'forgotPasswordSCren.dart';

class AuthScreen extends StatelessWidget {
  static String routName = '/AuthScreen';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confPassController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    bool isValidmail(String email) {
      final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      return emailValid;
    }

    bool loginValidation() {
      if (emailController.text.isEmpty ||
          isValidmail(emailController.text) == false) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Enter a vaid email')));
        return false;
      } else if (passwordController.text.isEmpty ||
          passwordController.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Enter a  password of at least 6 digit')));
        return false;
      }
      return true;
    }

    bool signupValidation() {
      if (emailController.text.isEmpty ||
          isValidmail(emailController.text) == false) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Enter a vaid email')));
        return false;
      } else if (passwordController.text.isEmpty ||
          passwordController.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Enter a  password of at least 6 digit')));
        return false;
      } else if (passwordController.text != confPassController.text) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Confirm password must be same as password')));
        return false;
      }
      return true;
    }

    return Consumer<MyProivder>(builder: (context, proivder, child) {
      return Scaffold(
        body: GradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset('assets/images/images.png'),
                    proivder.isLogin
                        ? SizedBox()
                        : CustomTextFiled(
                            controller: usernameController,
                            isValid: (val) => val.isNotEmpty,
                            headingText: 'Username',
                            hintText: 'Username'),
                    CustomTextFiled(
                        controller: emailController,
                        isValid: (val) => val.isNotEmpty,
                        headingText: 'Email',
                        hintText: 'Email'),
                    CustomTextFiled(
                        obscureText: proivder.hidePassword,
                        suffix: IconButton(
                          onPressed: () => proivder.togglePassword(),
                          icon: Icon(proivder.hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        controller: passwordController,
                        isValid: (val) => val.isNotEmpty,
                        headingText: 'password',
                        hintText: 'password'),
                    proivder.isLogin
                        ? SizedBox()
                        : CustomTextFiled(
                            obscureText: proivder.hideConfirmPassword,
                            suffix: IconButton(
                              onPressed: () => proivder.toggleConfirmPassword(),
                              icon: Icon(proivder.hideConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            controller: confPassController,
                            isValid: (val) => val.isNotEmpty,
                            headingText: 'Confirm password',
                            hintText: 'Confirm password'),
                    const SizedBox(
                      height: 30,
                    ),
                    proivder.isLogin
                        ? InkWell(
                            onTap: () async {
                              if (loginValidation()) {
                                print('login success');
                                proivder.signIn(emailController.text,
                                    passwordController.text, context);
                              }
                              print('not valid${loginValidation()}');
                            },
                            child: proivder.loading
                                ? showLoading()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                          color: indigo,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                          )
                        : InkWell(
                            onTap: () async {
                              if (signupValidation()) {
                                proivder.signUp(emailController.text,
                                    passwordController.text, context);
                              } else {}
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: indigo,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        proivder.setLogin();
                      },
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: proivder.isLogin
                                ? 'Don\'t have an account? '
                                : 'Already Have an account..',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                        TextSpan(
                            text: proivder.isLogin ? 'Sign Up' : 'login',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500))
                      ])),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          )),
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Forgot Password ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ])),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
