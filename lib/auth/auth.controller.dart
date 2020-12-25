import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtodo/auth/auth.service.dart';
import 'package:getxtodo/signin_enum.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  RxBool isLogged = false.obs;
  TextEditingController emailController;
  TextEditingController passwordController;
  AuthService _authService;
  Rx<FirebaseUser> user = Rx<FirebaseUser>();

  AuthController() {
    _authService = AuthService();
  }

  @override
  void onInit() async {
    ever(isLogged, handleAuthChanged);
    user.value = await _authService.getCurrentUser();
    isLogged.value = user.value != null;
    _authService.onAuthChanged().listen((event) {
      isLogged.value = event != null;
      user.value = event;
    });
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController?.dispose();
    passwordController?.dispose();
    super.onClose();
  }

  handleAuthChanged(isLoggedIn) {
    if (isLoggedIn == false) {
      Get.offAllNamed("/login");
    } else {
      Get.offAllNamed("/");
    }
  }

  handleSignIn(SignInType type) async {
    if (type == SignInType.EMAIL_PASSWORD) {
      if (emailController.text == "" || passwordController.text == "") {
        Get.snackbar(
          "Error",
          "Empty email or password",
        );
        return;
      }
    }

    Get.snackbar("Signing In", "Loading",
        showProgressIndicator: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(minutes: 2));
    try {
      if (type == SignInType.EMAIL_PASSWORD) {
        await _authService.signInWithEmailAndPassword(
            emailController.text.trim(), passwordController.text.trim());
        emailController.clear();
        passwordController.clear();
      }
      if (type == SignInType.GOOGLE) {
        await _authService.signInWithGoogle();
      }
    } catch (e) {
      Get.back();
      Get.defaultDialog(title: "Error", middleText: e.message, actions: [
        FlatButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Close"),
        ),
      ]);
      print(e);
    }
  }

  handleSignUp() async {
    if (emailController.text == "" || passwordController.text == "") {
      Get.snackbar(
        "Error",
        "Empty email or password",
      );
      return;
    }

    Get.snackbar("Signing Up", "Loading",
        showProgressIndicator: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(minutes: 2));
    try {
      await _authService.signUp(
          emailController.text.trim(), passwordController.text.trim());
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      Get.back();
      Get.defaultDialog(title: "Error", middleText: e.message, actions: [
        FlatButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Close"),
        ),
      ]);
      print(e);
    }
  }

  handleSignOut() {
    _authService.signOut();
  }
}
