import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final namaController = TextEditingController();
  final nomorHpController = TextEditingController();
  final alamatController = TextEditingController();
  
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final passwordVisible = false.obs;
  final confirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisible.value = !confirmPasswordVisible.value;
  }

  void register() async {
    if (passwordController.text != confirmPasswordController.text) {
      errorMessage.value = 'Password tidak sama';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      // TODO: Implement register API call
      await Future.delayed(Duration(seconds: 1)); // Simulate API call
      
      // Jika berhasil, navigasi ke login
      Get.offAllNamed('/login');
    } catch (e) {
      errorMessage.value = 'Gagal mendaftar: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    namaController.dispose();
    nomorHpController.dispose();
    alamatController.dispose();
    super.onClose();
  }
}