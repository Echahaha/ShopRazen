import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LupaPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Email tidak valid';
    }
    return null;
  }

  void resetPassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      // TODO: Implement reset password API call
      await Future.delayed(Duration(seconds: 1)); // Simulate API call
      
      // Jika berhasil, navigasi ke OTP verification
      Get.toNamed('/otp-verification', arguments: {
        'email': emailController.text,
        'fromResetPassword': true
      });
    } catch (e) {
      errorMessage.value = 'Gagal mengirim reset password: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
