import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoprazen/app/modules/dashboard_customer/home/controllers/home_controller.dart';

// Wishlist Controller
class WishlistController extends GetxController {
  var isLoading = false.obs;
  var wishlistProducts = <Product>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    loadWishlist();
  }
  
  void loadWishlist() async {
    isLoading.value = true;
    
    // Simulate API call to fetch wishlist
    await Future.delayed(Duration(milliseconds: 500));
    
    // Get all products from HomeController
    var homeController = Get.find<HomeController>();
    wishlistProducts.value = homeController.products
        .where((product) => product.isWishlist)
        .toList();
    
    isLoading.value = false;
  }
  
  void removeFromWishlist(String productId) {
    wishlistProducts.removeWhere((product) => product.id == productId);
    
    // Update product in HomeController
    var homeController = Get.find<HomeController>();
    homeController.toggleWishlist(productId);
    
    Get.snackbar(
      'Wishlist',
      'Produk berhasil dihapus dari wishlist',
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }
  
  void clearWishlist() {
    Get.dialog(
      AlertDialog(
        title: Text('Hapus Semua'),
        content: Text('Apakah Anda yakin ingin menghapus semua produk dari wishlist?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              wishlistProducts.clear();
              Get.back();
              Get.snackbar(
                'Wishlist',
                'Semua produk berhasil dihapus',
                backgroundColor: Colors.green,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('Hapus Semua'),
          ),
        ],
      ),
    );
  }
  
  void consultProduct(String productId) {
    var homeController = Get.find<HomeController>();
    homeController.consultProduct(productId);
  }
}