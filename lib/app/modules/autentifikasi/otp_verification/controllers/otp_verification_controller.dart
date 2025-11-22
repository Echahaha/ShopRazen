import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  final otpController = TextEditingController();
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final email = ''.obs;
  final remainingTime = 60.obs;
  final canResend = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Ambil email dari arguments
    if (Get.arguments != null && Get.arguments['email'] != null) {
      email.value = Get.arguments['email'];
    }
    startTimer();
  }

  void startTimer() {
    remainingTime.value = 60;
    canResend.value = false;
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      remainingTime.value--;
      if (remainingTime.value <= 0) {
        canResend.value = true;
        return false;
      }
      return true;
    });
  }

  void verifyOtp() async {
    if (otpController.text.length != 6) {
      errorMessage.value = 'Kode OTP harus 6 digit';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      // TODO: Implement OTP verification API call
      await Future.delayed(Duration(seconds: 1)); // Simulate API call
      
      // Jika verifikasi berhasil
      Get.offAllNamed('/login');
    } catch (e) {
      errorMessage.value = 'Verifikasi gagal: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  void resendOtp() async {
    if (!canResend.value) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      // TODO: Implement resend OTP API call
      await Future.delayed(Duration(seconds: 1)); // Simulate API call
      
      startTimer();
    } catch (e) {
      errorMessage.value = 'Gagal mengirim ulang OTP: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
