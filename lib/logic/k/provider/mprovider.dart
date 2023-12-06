import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../widget/showToas.dart';
import '../../../screen/auth/authscreen.dart';
import '../../../screen/dashboard/dashboard.dart';

class MyProivder extends ChangeNotifier {
  bool loading = false;
  bool loadingforgotPsssword = false;
  bool logoutLoading = false;
  bool hidePassword = false;
  setIsloading(value) {
    loading = value;
    notifyListeners();
  }

  setIsloadingforgotPassword(value) {
    loadingforgotPsssword = value;
    notifyListeners();
  }

  setlogoutLoading(value) {
    loading = value;
    notifyListeners();
  }

  togglePassword() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  bool hideConfirmPassword = false;
  toggleConfirmPassword() {
    hideConfirmPassword = !hideConfirmPassword;
    notifyListeners();
  }

  bool isLogin = false;
  setLogin() {
    isLogin = !isLogin;
    notifyListeners();
  }

  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;

  signUp(String emailAddress, String password, context) async {
    try {
      setIsloading(true);
      final credential = await _firebaseauth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      setIsloading(false);

      if (credential.additionalUserInfo != null) {
        setIsloading(false);
        showGoodToast(
            '${credential.user?.email.toString()} registered successfully!');

        Navigator.pushNamedAndRemoveUntil(
            context, DashBoardPage.routeName, (route) => false);
      }
      {
        // Navigator.pop(context);
        setIsloading(false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        showErrorToast('${e.code}');
        setIsloading(false);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        showErrorToast('${e.code}');
        setIsloading(false);
      }
    } catch (e) {
      print(e);
      showErrorToast('${e}');
      setIsloading(false);
    }
  }

  signIn(String emailAddress, String password, context) async {
    try {
      setIsloading(true);

      final credential = await _firebaseauth.signInWithEmailAndPassword(
          email: emailAddress, password: password);

      print('additionalUserInfo  ${credential.user} ${credential.credential}');
      if (credential.additionalUserInfo != null) {
        showGoodToast(
            '${credential.user?.email.toString()} Login  successfully!');

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => DashBoardPage(),
        //     ));
        setIsloading(false);
        Navigator.pushNamedAndRemoveUntil(
            context, DashBoardPage.routeName, (route) => false);
      }
      {
        // Navigator.pop(context);
        setIsloading(false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');

        setIsloading(false);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showErrorToast('${e.code}');
        setIsloading(false);
      }
    }
  }

  forgotPassword(String email, context) async {
    try {
      setIsloadingforgotPassword(true);

      await _firebaseauth.sendPasswordResetEmail(email: email).then((value) {
        showGoodToast(
            'Reset password link has been sent to your $email email address');

        setIsloadingforgotPassword(false);
        Navigator.pushNamed(
          context,
          AuthScreen.routName,
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'auth/invalid-email') {
        print('email address is not valid.');
        setIsloadingforgotPassword(false);
        showErrorToast('${e.code}');
      } else if (e.code == 'auth/user-not-found') {
        print('user-not-found');
        showErrorToast('${e.code}');
        setIsloadingforgotPassword(false);
      }
      setIsloadingforgotPassword(false);
    }
  }

  logout(context) async {
    try {
      setlogoutLoading(true);

      await _firebaseauth.signOut().then((value) {
        showGoodToast('Logout successfully!');

        setlogoutLoading(false);
        Navigator.pushNamedAndRemoveUntil(
          context,
          AuthScreen.routName,
          (route) => false,
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'auth/invalid-email') {
        print('email address is not valid.');
        setlogoutLoading(false);
        showErrorToast('${e.code}');
      } else if (e.code == 'auth/user-not-found') {
        print('user-not-found');
        showErrorToast('${e.code}');
        setlogoutLoading(false);
      }
      setlogoutLoading(false);
    }
  }
}
