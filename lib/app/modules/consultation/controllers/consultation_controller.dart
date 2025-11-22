import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/order_model.dart';
import '../../../routes/app_pages.dart';

class ConsultationController extends GetxController {
  final product = Rxn<dynamic>();
  final isLoading = false.obs;
  final consultationNotes = ''.obs;
  
  // WhatsApp Configuration - GANTI DENGAN NOMOR ANDA
  final String whatsappNumber = '6285156439049'; // Format: 62 + nomor tanpa 0
  final String whatsappMessage = 'Halo, saya tertarik untuk konsultasi produk ';

  @override
  void onInit() {
    super.onInit();
    product.value = Get.arguments;
  }

  void openWhatsApp() async {
    final productName = product.value?.name ?? 'Produk';
    final message = Uri.encodeComponent('$whatsappMessage$productName');
    final whatsappUrl = 'https://wa.me/$whatsappNumber?text=$message';
    
    try {
      final uri = Uri.parse(whatsappUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'Error',
          'Tidak dapat membuka WhatsApp',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void proceedToPayment() {
    if (consultationNotes.value.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Silakan isi catatan konsultasi terlebih dahulu',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Create order
    final order = OrderModel(
      id: 'ORD${DateTime.now().millisecondsSinceEpoch}',
      productName: product.value?.name ?? '',
      price: product.value?.price ?? '',
      status: OrderStatus.waitingPayment,
      createdAt: DateTime.now(),
      consultationNotes: consultationNotes.value,
      progress: [
        OrderProgress(
          title: 'Konsultasi Selesai',
          description: 'Konsultasi produk telah selesai',
          timestamp: DateTime.now(),
          isCompleted: true,
        ),
      ],
      paymentProof: null, // menambahkan field paymentProof yang bisa null
    );

    Get.toNamed(Routes.PAYMENT, arguments: order);
  }

  void updateNotes(String value) {
    consultationNotes.value = value;
  }
}