import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../data/models/order_model.dart';
import '../../../../routes/app_pages.dart';

class OrderTrackingController extends GetxController {
  final order = Rxn<OrderModel>();
  final isLoading = false.obs;

  // WhatsApp Support - GANTI DENGAN NOMOR WA SUPPORT ANDA
  final String supportWhatsApp = '6281234567890'; // Format: 62 + nomor tanpa 0

  @override
  void onInit() {
    super.onInit();
    order.value = Get.arguments as OrderModel?;
    // Simulate real-time updates
    simulateProgress();
  }

  void simulateProgress() {
    // Simulasi update progress secara berkala (untuk demo)
    // Dalam aplikasi real, ini akan diganti dengan polling API atau WebSocket
    Future.delayed(Duration(seconds: 5), () {
      if (order.value != null && order.value!.status == OrderStatus.processing) {
        final updatedProgress = [
          ...order.value!.progress,
          OrderProgress(
            title: 'Analisis Requirement',
            description: 'Tim sedang menganalisis kebutuhan proyek Anda',
            timestamp: DateTime.now(),
            isCompleted: true,
          ),
        ];
        order.value = order.value!.copyWith(progress: updatedProgress);
      }
    });

    // Simulasi progress kedua
    Future.delayed(Duration(seconds: 15), () {
      if (order.value != null && order.value!.status == OrderStatus.processing) {
        final updatedProgress = [
          ...order.value!.progress,
          OrderProgress(
            title: 'Desain UI/UX',
            description: 'Proses desain interface sedang berlangsung',
            timestamp: DateTime.now(),
            isCompleted: false,
          ),
        ];
        order.value = order.value!.copyWith(progress: updatedProgress);
      }
    });
  }

  String getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.consultation:
        return 'Konsultasi';
      case OrderStatus.waitingPayment:
        return 'Menunggu Pembayaran';
      case OrderStatus.waitingContract:
        return 'Menunggu Kontrak';
      case OrderStatus.processing:
        return 'Sedang Diproses';
      case OrderStatus.completed:
        return 'Selesai';
      case OrderStatus.cancelled:
        return 'Dibatalkan';
    }
  }

  Color getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.consultation:
        return Colors.blue;
      case OrderStatus.waitingPayment:
        return Colors.orange;
      case OrderStatus.waitingContract:
        return Colors.purple;
      case OrderStatus.processing:
        return Colors.blue;
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  void contactSupport() async {
    final orderId = order.value?.id ?? '';
    final message = Uri.encodeComponent(
        'Halo, saya ingin bertanya tentang pesanan saya dengan Order ID: $orderId');
    final whatsappUrl = 'https://wa.me/$supportWhatsApp?text=$message';

    try {
      final uri = Uri.parse(whatsappUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'Error',
          'Tidak dapat membuka WhatsApp',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void backToHome() {
    Get.offAllNamed(Routes.HOME);
  }

  void refreshOrder() {
    isLoading.value = true;
    
    // Simulasi refresh data dari server
    // Dalam aplikasi real, ini akan call API untuk get latest order status
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      
      // Simulasi update progress baru setelah refresh
      if (order.value != null && order.value!.status == OrderStatus.processing) {
        final updatedProgress = [
          ...order.value!.progress,
          OrderProgress(
            title: 'Progress Terbaru',
            description: 'Data pesanan telah diperbarui pada ${DateTime.now().hour}:${DateTime.now().minute}',
            timestamp: DateTime.now(),
            isCompleted: false,
          ),
        ];
        order.value = order.value!.copyWith(progress: updatedProgress);
      }
      
      Get.snackbar(
        'Berhasil',
        'Data pesanan telah diperbarui',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    });
  }

  // Method untuk cancel order (optional, bisa diaktifkan jika diperlukan)
  void cancelOrder() {
    Get.dialog(
      AlertDialog(
        title: Text('Batalkan Pesanan?'),
        content: Text('Apakah Anda yakin ingin membatalkan pesanan ini?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              
              // Update order status to cancelled
              order.value = order.value!.copyWith(
                status: OrderStatus.cancelled,
                progress: [
                  ...order.value!.progress,
                  OrderProgress(
                    title: 'Pesanan Dibatalkan',
                    description: 'Pesanan telah dibatalkan oleh pelanggan',
                    timestamp: DateTime.now(),
                    isCompleted: true,
                  ),
                ],
              );
              
              Get.snackbar(
                'Berhasil',
                'Pesanan telah dibatalkan',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.orange,
                colorText: Colors.white,
              );
            },
            child: Text('Ya, Batalkan', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Method untuk mark as completed (untuk admin atau testing)
  void markAsCompleted() {
    order.value = order.value!.copyWith(
      status: OrderStatus.completed,
      progress: [
        ...order.value!.progress,
        OrderProgress(
          title: 'Pesanan Selesai',
          description: 'Pesanan telah selesai dikerjakan dan diserahkan',
          timestamp: DateTime.now(),
          isCompleted: true,
        ),
      ],
    );
    
    Get.snackbar(
      'Selamat! 🎉',
      'Pesanan Anda telah selesai',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
    );
  }

  // Method untuk download invoice (optional feature)
  void downloadInvoice() {
    Get.snackbar(
      'Info',
      'Fitur download invoice akan segera tersedia',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  // Method untuk rating & review setelah selesai (optional feature)
  void openReviewPage() {
    if (order.value?.status == OrderStatus.completed) {
      Get.snackbar(
        'Info',
        'Fitur rating & review akan segera tersedia',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Perhatian',
        'Review hanya dapat diberikan setelah pesanan selesai',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }
}