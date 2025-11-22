// lib/app/modules/dashboard_customer/payment/controllers/payment_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/models/order_model.dart';
import '../../../../routes/app_pages.dart';

class PaymentController extends GetxController {
  final order = Rxn<OrderModel>();
  final selectedPaymentMethod = ''.obs;
  final paymentProof = Rxn<XFile>();
  final isLoading = false.obs;

  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      id: 'bca',
      name: 'Bank BCA',
      accountNumber: '1234567890',
      accountName: 'PT Razen Digital',
      icon: Icons.account_balance,
    ),
    PaymentMethod(
      id: 'mandiri',
      name: 'Bank Mandiri',
      accountNumber: '0987654321',
      accountName: 'PT Razen Digital',
      icon: Icons.account_balance,
    ),
    PaymentMethod(
      id: 'bni',
      name: 'Bank BNI',
      accountNumber: '5555666677',
      accountName: 'PT Razen Digital',
      icon: Icons.account_balance,
    ),
    PaymentMethod(
      id: 'gopay',
      name: 'GoPay',
      accountNumber: '081234567890',
      accountName: 'Razen Digital',
      icon: Icons.account_balance_wallet,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args == null) {
      Get.snackbar(
        'Error',
        'Data pesanan tidak ditemukan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      Get.back();
      return;
    }
    order.value = args as OrderModel;
  }

  void selectPaymentMethod(String methodId) {
    selectedPaymentMethod.value = methodId;
  }

  void copyAccountNumber(String accountNumber) async {
    try {
      await Clipboard.setData(ClipboardData(text: accountNumber));
      Get.snackbar(
        'Berhasil',
        'Nomor rekening berhasil disalin',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menyalin nomor rekening',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> pickPaymentProof() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        // Check file size (max 5MB)
        final bytes = await image.length();
        final maxSize = 5 * 1024 * 1024; // 5MB in bytes
        
        if (bytes > maxSize) {
          Get.snackbar(
            'Error',
            'Ukuran file terlalu besar (maksimal 5MB)',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        paymentProof.value = image;
        Get.snackbar(
          'Berhasil',
          'Bukti pembayaran berhasil dipilih',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memilih gambar: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> proceedToContract() async {
    if (selectedPaymentMethod.value.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Silakan pilih metode pembayaran',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (paymentProof.value == null) {
      Get.snackbar(
        'Perhatian',
        'Silakan upload bukti pembayaran',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      
      // Update order with payment info
      final updatedOrder = order.value!.copyWith(
        status: OrderStatus.waitingContract,
        paymentProof: paymentProof.value!.path,
        progress: [
          ...order.value!.progress,
          OrderProgress(
            title: 'Pembayaran Diunggah',
            description: 'Bukti pembayaran telah diunggah dan menunggu verifikasi',
            timestamp: DateTime.now(),
            isCompleted: true,
          ),
          OrderProgress(
            title: 'Menunggu Kontrak',
            description: 'Menunggu penandatanganan kontrak digital',
            timestamp: DateTime.now(),
            isCompleted: false,
          ),
        ],
      );

      await Get.toNamed(Routes.CONTRACT, arguments: updatedOrder);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memproses pembayaran: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

class PaymentMethod {
  final String id;
  final String name;
  final String accountNumber;
  final String accountName;
  final IconData icon;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.accountName,
    required this.icon,
  });
}