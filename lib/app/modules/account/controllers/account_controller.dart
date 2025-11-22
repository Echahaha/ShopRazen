import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  var userName = 'Pengguna Razen'.obs;
  var userEmail = 'user@razen.com'.obs;
  var userPhone = '+62 812-3456-7890'.obs;
  var isLoggedIn = true.obs;

  // Stats
  var totalOrders = 12.obs;
  var totalWishlist = 3.obs;
  var totalReviews = 8.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    // Simulate loading user data from API or local storage
    // Nanti bisa diganti dengan actual API call
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        title: Text('Konfirmasi Logout'),
        content: Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              isLoggedIn.value = false;
              Get.back();
              Get.snackbar(
                'Berhasil',
                'Anda telah keluar dari akun',
                backgroundColor: Colors.green,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
              // Navigate to login page
              // Get.offAllNamed('/login');
            },
            child: Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void navigateToEditProfile() {
    Get.toNamed('/edit-profile');
  }

  void navigateToChangePassword() {
    Get.toNamed('/change-password');
  }

  void navigateToAddresses() {
    Get.toNamed('/addresses');
  }

  void navigateToWishlist() {
    Get.toNamed('/wishlist');
  }

  void navigateToTransactionHistory() {
    Get.toNamed('/transaction-history');
  }

  void navigateToMyReviews() {
    Get.toNamed('/my-reviews');
  }

  void navigateToNotifications() {
    Get.toNamed('/notifications');
  }

  void navigateToHelp() {
    Get.toNamed('/help');
  }

  void navigateToAbout() {
    Get.toNamed('/about');
  }

  void navigateToPrivacyPolicy() {
    Get.toNamed('/privacy-policy');
  }

  void navigateToTerms() {
    Get.toNamed('/terms');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}