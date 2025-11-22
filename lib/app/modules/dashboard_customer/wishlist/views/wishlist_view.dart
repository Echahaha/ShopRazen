import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shoprazen/app/modules/dashboard_customer/home/controllers/home_controller.dart' show Product;

import '../controllers/wishlist_controller.dart';

class WishlistView extends StatelessWidget {
  final WishlistController controller = Get.put(WishlistController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist Saya'),
        elevation: 0,
        actions: [
          Obx(() => controller.wishlistProducts.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: controller.clearWishlist,
                  tooltip: 'Hapus Semua',
                )
              : SizedBox()),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        
        if (controller.wishlistProducts.isEmpty) {
          return _buildEmptyState();
        }
        
        return _buildWishlistContent();
      }),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 100,
            color: Colors.grey[300],
          ),
          SizedBox(height: 20),
          Text(
            'Wishlist Kosong',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Belum ada produk yang ditandai',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () => Get.back(),
            icon: Icon(Icons.shopping_bag),
            label: Text('Jelajahi Produk'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildWishlistContent() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.favorite, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Obx(() => Text(
                '${controller.wishlistProducts.length} Produk',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.wishlistProducts.length,
            itemBuilder: (context, index) {
              var product = controller.wishlistProducts[index];
              return _buildWishlistCard(product);
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildWishlistCard(Product product) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to product detail
          Get.toNamed('/product-detail', arguments: product);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: Icon(Icons.image, color: Colors.grey[500]),
                    );
                  },
                ),
              ),
              SizedBox(width: 12),
              
              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          product.rating.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            product.category,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      product.price,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Action Buttons
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () => controller.removeFromWishlist(product.id),
                    tooltip: 'Hapus dari wishlist',
                  ),
                  SizedBox(height: 8),
                  IconButton(
                    icon: Icon(Icons.chat_bubble_outline, color: Colors.green),
                    onPressed: () => controller.consultProduct(product.id),
                    tooltip: 'Konsultasi',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Updated Product Model (add copyWith method)
extension ProductExtension on Product {
  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    String? price,
    String? divisionId,
    String? category,
    double? rating,
    bool? isWishlist,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      divisionId: divisionId ?? this.divisionId,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      isWishlist: isWishlist ?? this.isWishlist,
    );
  }
}