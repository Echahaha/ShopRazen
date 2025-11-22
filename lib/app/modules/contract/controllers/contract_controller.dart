// lib/app/modules/contract/controllers/contract_controller.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import '../../../data/models/order_model.dart';
import '../../../routes/app_pages.dart';

class ContractController extends GetxController {
  final order = Rxn<OrderModel>();
  final hasReadContract = false.obs;
  final isSubmitting = false.obs;

  late final SignatureController signatureController;

  final contractText = '''
PERJANJIAN PEMBUATAN APLIKASI MOBILE

PIHAK PERTAMA (Klien):
Nama: [Nama Klien]
Alamat: [Alamat Klien]

PIHAK KEDUA (Developer):
PT Razen Digital
Alamat: [Alamat Perusahaan]

PASAL 1: OBJEK PERJANJIAN
1. Pihak Kedua setuju untuk membuat dan mengembangkan aplikasi mobile sesuai dengan spesifikasi yang telah disepakati.
2. Detail proyek dan spesifikasi teknis telah dijelaskan dalam dokumen terpisah yang merupakan bagian tidak terpisahkan dari perjanjian ini.

PASAL 2: JANGKA WAKTU
1. Pengerjaan proyek dimulai setelah penandatanganan kontrak ini.
2. Estimasi waktu penyelesaian adalah sesuai dengan yang tertera pada detail order.
3. Perpanjangan waktu dapat dilakukan atas kesepakatan kedua belah pihak.

PASAL 3: HARGA DAN PEMBAYARAN
1. Harga telah disepakati sesuai dengan detail order.
2. Pembayaran dilakukan sesuai dengan skema yang telah disepakati.
3. Keterlambatan pembayaran dapat mengakibatkan penundaan pengerjaan proyek.

PASAL 4: HAK DAN KEWAJIBAN PIHAK PERTAMA
1. Menyediakan semua data dan informasi yang diperlukan untuk pengerjaan proyek.
2. Melakukan pembayaran sesuai dengan kesepakatan.
3. Memberikan feedback dan approval pada setiap milestone yang ditentukan.

PASAL 5: HAK DAN KEWAJIBAN PIHAK KEDUA
1. Mengerjakan proyek sesuai dengan spesifikasi yang telah disepakati.
2. Memberikan update progress secara berkala kepada Pihak Pertama.
3. Menjaga kerahasiaan data dan informasi yang diberikan oleh Pihak Pertama.
4. Menyerahkan source code dan dokumentasi lengkap setelah proyek selesai.

PASAL 6: REVISI DAN PERUBAHAN
1. Revisi minor dapat dilakukan sesuai dengan kesepakatan awal.
2. Perubahan major yang tidak termasuk dalam scope awal akan dikenakan biaya tambahan.
3. Semua perubahan harus didokumentasikan dan disetujui oleh kedua belah pihak.

PASAL 7: HAK CIPTA DAN KEPEMILIKAN
1. Setelah pembayaran penuh dilakukan, source code dan semua hak terkait aplikasi menjadi milik Pihak Pertama.
2. Pihak Kedua berhak mencantumkan proyek ini dalam portfolio dengan persetujuan Pihak Pertama.

PASAL 8: KERAHASIAAN
1. Kedua belah pihak wajib menjaga kerahasiaan informasi yang diperoleh selama masa kerjasama.
2. Kewajiban kerahasiaan ini tetap berlaku setelah berakhirnya perjanjian.

PASAL 9: FORCE MAJEURE
1. Tidak ada pihak yang bertanggung jawab atas kegagalan memenuhi kewajiban yang disebabkan oleh force majeure.
2. Force majeure termasuk namun tidak terbatas pada bencana alam, perang, pandemi, dan kebijakan pemerintah.

PASAL 10: PENYELESAIAN SENGKETA
1. Segala perselisihan akan diselesaikan secara musyawarah.
2. Jika tidak tercapai kesepakatan, penyelesaian dilakukan melalui jalur hukum yang berlaku di Indonesia.

PASAL 11: PENUTUP
1. Perjanjian ini dibuat dalam rangkap 2 (dua) yang masing-masing mempunyai kekuatan hukum yang sama.
2. Perjanjian ini mulai berlaku sejak ditandatangani oleh kedua belah pihak.

Dengan menandatangani kontrak digital ini, saya menyatakan bahwa saya telah membaca, memahami, dan menyetujui seluruh isi perjanjian ini.
'''.obs;

  @override
  void onInit() {
    super.onInit();
    
    // Initialize signature controller
    signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );

    // Get order from arguments
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

  @override
  void onClose() {
    signatureController.dispose();
    super.onClose();
  }

  void toggleReadContract() {
    hasReadContract.value = !hasReadContract.value;
  }

  void clearSignature() {
    signatureController.clear();
    Get.snackbar(
      'Berhasil',
      'Tanda tangan telah dihapus',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
  }

  Future<void> submitContract() async {
    // Validasi
    if (!hasReadContract.value) {
      Get.snackbar(
        'Perhatian',
        'Harap baca dan setujui kontrak terlebih dahulu',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (signatureController.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Harap berikan tanda tangan Anda',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isSubmitting.value = true;

      // Export signature as image
      final Uint8List? signatureBytes = await signatureController.toPngBytes();

      if (signatureBytes == null) {
        throw Exception('Gagal mengkonversi tanda tangan');
      }

      // Simulate API call delay
      await Future.delayed(Duration(seconds: 2));

      // Update order status
      final updatedOrder = order.value!.copyWith(
        status: OrderStatus.processing,
        signatureData: signatureBytes,
        contractSignedAt: DateTime.now(),
        progress: [
          ...order.value!.progress,
          OrderProgress(
            title: 'Kontrak Ditandatangani',
            description: 'Kontrak telah ditandatangani secara digital',
            timestamp: DateTime.now(),
            isCompleted: true,
          ),
          OrderProgress(
            title: 'Proyek Dimulai',
            description: 'Tim developer sedang mengerjakan proyek Anda',
            timestamp: DateTime.now(),
            isCompleted: false,
          ),
        ],
      );

      Get.snackbar(
        'Berhasil',
        'Kontrak berhasil ditandatangani',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );

      // Navigate to order detail or home
      await Future.delayed(Duration(milliseconds: 500));
      Get.offAllNamed(Routes.HOME);

    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal submit kontrak: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }
}