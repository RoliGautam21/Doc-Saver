import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constant/colors.dart';
import '../../widget/gradientBack.dart';
import '../../widget/mywidget.dart';
import '../../logic/k/provider/mprovider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  static final _key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool isValidmail(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(style: ButtonStyle()),
      ),
      body: Consumer<MyProivder>(
        builder: (context, provider, child) {
          return GradientBackground(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset('assets/images/images.png'),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFiled(
                        preffix: Icon(Icons.email_outlined),
                        controller: emailController,
                        isValid: (val) => val.isNotEmpty,
                        headingText: 'Email',
                        hintText: 'Email'),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        if (emailController.text.isNotEmpty &&
                            isValidmail(emailController.text) == true) {
                          provider.forgotPassword(
                              emailController.text, context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Enter a valid email')));
                        }
                      },
                      child: provider.loadingforgotPsssword
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
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
