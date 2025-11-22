import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoprazen/app/routes/app_pages.dart';

// Models
class Division {
  final String id;
  final String name;
  final String icon;
  final Color color;

  Division({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class Product {
  final String id;
  final String name;
  final String description;
  final String image;
  final String price;
  final String divisionId;
  final String category;
  final double rating;
  final bool isWishlist;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.divisionId,
    required this.category,
    required this.rating,
    this.isWishlist = false,
  });
}

class Article {
  final String id;
  final String title;
  final String excerpt;
  final String image;
  final DateTime publishedAt;

  Article({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.image,
    required this.publishedAt,
  });
}

// Controller
class HomeController extends GetxController {
  var isLoading = false.obs;
  var selectedDivision = ''.obs;
  var searchQuery = ''.obs;
  var selectedCategory = 'Semua'.obs;
  var animatingWishlist = ''.obs; // Untuk mengontrol animasi wishlist

  var divisions = <Division>[].obs;
  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var featuredProducts = <Product>[].obs;
  var articles = <Article>[].obs;
  var wishlist = <String>[].obs; // Menyimpan ID produk yang ada di wishlist
  var categories = <String>[
    'Semua',
    'Website',
    'Mobile App',
    'UI/UX Design',
    'Video Production'
  ].obs;

  @override
  void onInit() {
    super.onInit();
    initializeData();
    loadData();
  }

void initializeData() {
  divisions.value = [
    Division(
      id: 'teknologi',
      name: 'Teknologi',
      icon: 'assets/LogoRazen/Teknologi.png',
      color: Colors.blue,
    ),
    Division(
      id: 'studio',
      name: 'Studio',
      icon: 'assets/LogoRazen/Studio.png',
      color: Colors.red,
    ),
    Division(
      id: 'kolhype',
      name: 'Kolhype',
      icon: 'assets/LogoRazen/Kolhype.png',
      color: Colors.yellow,
    ),
    Division(
      id: 'project',
      name: 'Project',
      icon: 'assets/LogoRazen/Project.png',
      color: Colors.orange,
    ),
    Division(
      id: 'institute',
      name: 'Institute',
      icon: 'assets/LogoRazen/Institute.png',
      color: Colors.brown,
    ),
  ];

    // Initialize wishlist
    wishlist.value = ['1']; // Contoh: produk 1 sudah di-wishlist

    products.value = [
      Product(
        id: '1',
        name: 'Website Development',
        description: 'Pembuatan website responsive dan modern',
        image: 'https://via.placeholder.com/300x200',
        price: 'Mulai dari Rp 2.500.000',
        divisionId: 'teknologi',
        category: 'Website',
        rating: 4.8,
        isWishlist: true, // Set initial wishlist status
      ),
      Product(
        id: '2',
        name: 'Mobile App Development',
        description: 'Aplikasi mobile Android dan iOS',
        image: 'https://via.placeholder.com/300x200',
        price: 'Mulai dari Rp 5.000.000',
        divisionId: 'teknologi',
        category: 'Mobile App',
        rating: 4.9,
      ),
      Product(
        id: '3',
        name: 'Video Production',
        description: 'Jasa produksi video profesional',
        image: 'https://via.placeholder.com/300x200',
        price: 'Mulai dari Rp 1.500.000',
        divisionId: 'studio',
        category: 'Video Production',
        rating: 4.7,
      ),
    ];

    articles.value = [
      Article(
        id: '1',
        title: 'Tren Teknologi 2024',
        excerpt: 'Perkembangan teknologi terbaru yang wajib diketahui...',
        image: 'https://via.placeholder.com/300x200',
        publishedAt: DateTime.now().subtract(Duration(days: 1)),
      ),
      Article(
        id: '2',
        title: 'Tips Memilih Digital Agency',
        excerpt: 'Panduan lengkap memilih partner digital yang tepat...',
        image: 'https://via.placeholder.com/300x200',
        publishedAt: DateTime.now().subtract(Duration(days: 3)),
      ),
    ];

    filterProducts();
  }

  void loadData() async {
    isLoading.value = true;
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    featuredProducts.value = products.take(3).toList();
    isLoading.value = false;
  }

  void selectDivision(String divisionId) {
    selectedDivision.value =
        selectedDivision.value == divisionId ? '' : divisionId;
    filterProducts();
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    filterProducts();
  }

  void searchProducts(String query) {
    searchQuery.value = query;
    filterProducts();
  }

  void filterProducts() {
    var filtered = products.where((product) {
      bool matchDivision = selectedDivision.value.isEmpty ||
          product.divisionId == selectedDivision.value;
      bool matchCategory = selectedCategory.value == 'Semua' ||
          product.category == selectedCategory.value;
      bool matchSearch = searchQuery.value.isEmpty ||
          product.name
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()) ||
          product.description
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());

      return matchDivision && matchCategory && matchSearch;
    }).toList();

    filteredProducts.value = filtered;
  }

  void toggleWishlist(String productId) async {
    try {
      // Set ID produk yang sedang dianimasikan
      animatingWishlist.value = productId;
      
      var productIndex = products.indexWhere((p) => p.id == productId);
      if (productIndex != -1) {
        // Buat salinan produk lama
        var oldProduct = products[productIndex];
        
        // Buat produk baru dengan status wishlist yang diubah
        var newProduct = Product(
          id: oldProduct.id,
          name: oldProduct.name,
          description: oldProduct.description,
          image: oldProduct.image,
          price: oldProduct.price,
          divisionId: oldProduct.divisionId,
          category: oldProduct.category,
          rating: oldProduct.rating,
          isWishlist: !oldProduct.isWishlist,
        );

        // Update products list
        products[productIndex] = newProduct;
        
        // Update filtered products jika produk ada di dalamnya
        var filteredIndex = filteredProducts.indexWhere((p) => p.id == productId);
        if (filteredIndex != -1) {
          filteredProducts[filteredIndex] = newProduct;
        }
        
        // Update featured products jika produk ada di dalamnya
        var featuredIndex = featuredProducts.indexWhere((p) => p.id == productId);
        if (featuredIndex != -1) {
          featuredProducts[featuredIndex] = newProduct;
        }

        // Update wishlist list
        if (newProduct.isWishlist) {
          wishlist.add(productId);
          Get.snackbar(
            'Berhasil',
            'Produk ditambahkan ke wishlist',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          wishlist.remove(productId);
          Get.snackbar(
            'Berhasil',
            'Produk dihapus dari wishlist',
            backgroundColor: Colors.orange,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengubah wishlist: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      // Reset animasi setelah 500ms
      await Future.delayed(Duration(milliseconds: 500));
      animatingWishlist.value = '';
    }
  }

  void consultProduct(String productId) {
    // Cari produk berdasarkan ID
    final product = products.firstWhereOrNull((p) => p.id == productId);

    if (product != null) {
      // Navigate ke halaman konsultasi dengan membawa data produk
      Get.toNamed(Routes.CONSULTATION, arguments: product);
    } else {
      Get.snackbar(
        'Error',
        'Produk tidak ditemukan',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
}
