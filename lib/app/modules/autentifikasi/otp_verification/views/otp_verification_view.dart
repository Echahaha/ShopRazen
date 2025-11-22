import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/otp_verification_controller.dart';

class OtpVerificationView extends GetView<OtpVerificationController> {
  const OtpVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verifikasi OTP'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 32),
            Text(
              'Verifikasi Email Anda',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Obx(() => Text(
              'Masukkan kode OTP yang telah dikirim ke\n${controller.email}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            )),
            SizedBox(height: 32),
            TextField(
              controller: controller.otpController,
              decoration: InputDecoration(
                labelText: 'Kode OTP',
                border: OutlineInputBorder(),
                hintText: '123456',
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 6,
            ),
            SizedBox(height: 16),
            Obx(() => controller.errorMessage.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      controller.errorMessage.value,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  )
                : SizedBox()),
            SizedBox(height: 16),
            Obx(() => ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.verifyOtp,
              child: controller.isLoading.value
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('Verifikasi'),
            )),
            SizedBox(height: 24),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tidak menerima kode? '),
                if (controller.remainingTime.value > 0) ...[
                  Text(
                    'Tunggu ${controller.remainingTime} detik',
                    style: TextStyle(color: Colors.grey),
                  ),
                ] else
                  TextButton(
                    onPressed: controller.canResend.value
                        ? controller.resendOtp
                        : null,
                    child: Text('Kirim Ulang'),
                  ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
