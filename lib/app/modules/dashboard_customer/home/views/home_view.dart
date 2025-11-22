import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.loadData();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildSearchBar(),
                _buildDivisionFilter(),
                _buildCategoryFilter(),
                _buildFeaturedProducts(),
                _buildProductGrid(),
                _buildArticleSection(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[600]!, Colors.blue[800]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // TAMBAHKAN INI
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Razen Shop',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Solusi Digital Terpercaya',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis, // TAMBAHKAN INI
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min, // TAMBAHKAN INI
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite, color: Colors.white),
                    onPressed: () => Get.toNamed('/wishlist'),
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications, color: Colors.white),
                    onPressed: () => Get.toNamed('/notifications'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(20),
      child: TextField(
        onChanged: controller.searchProducts,
        decoration: InputDecoration(
          hintText: 'Cari produk atau layanan...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildDivisionFilter() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Divisi Razen',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Obx(() => SizedBox(
                // UBAH dari Container ke SizedBox
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.divisions.length,
                  itemBuilder: (context, index) {
                    var division = controller.divisions[index];
                    bool isSelected =
                        controller.selectedDivision.value == division.id;

                    return GestureDetector(
                      onTap: () => controller.selectDivision(division.id),
                      child: Container(
                        width: 70, // KURANGI dari 80 ke 70
                        margin:
                            EdgeInsets.only(right: 12), // KURANGI dari 15 ke 12
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // TAMBAHKAN INI
                          children: [
                            Container(
                              width: 50, // KURANGI dari 60 ke 50
                              height: 50, // KURANGI dari 60 ke 50
                              decoration: BoxDecoration(
                                color:
                                    isSelected ? division.color : Colors.white,
                                borderRadius:
                                    BorderRadius.circular(25), // SESUAIKAN
                                border: Border.all(
                                  color: division.color,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Image.asset(
                                  division.icon,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error,
                                        color: Colors.red, size: 20);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Flexible(
                              // UBAH Text menjadi Flexible
                              child: Text(
                                division.name,
                                style: TextStyle(
                                  fontSize: 10, // KURANGI dari 12 ke 10
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? division.color
                                      : Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2, // UBAH dari 1 ke 2
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 40,
      child: Obx(() => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              var category = controller.categories[index];
              bool isSelected = controller.selectedCategory.value == category;

              return GestureDetector(
                onTap: () => controller.selectCategory(category),
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }

  Widget _buildFeaturedProducts() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Produk Unggulan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 15),
          Obx(() => Container(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: controller.featuredProducts.length,
                  itemBuilder: (context, index) {
                    var product = controller.featuredProducts[index];
                    return _buildFeaturedProductCard(product);
                  },
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildFeaturedProductCard(Product product) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = MediaQuery.of(context).size.width;
        double cardWidth =
            (screenWidth * 0.8).clamp(250.0, 320.0); // BATASI maksimal width

        return Container(
          width: cardWidth,
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Container(
                  height: 100, // KURANGI dari 120 ke 100
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Icon(Icons.image,
                      size: 40, color: Colors.grey[600]), // KURANGI size
                ),
              ),
              Expanded(
                // TAMBAHKAN Expanded
                child: Padding(
                  padding: EdgeInsets.all(10), // KURANGI dari 15 ke 12
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // TAMBAHKAN INI
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 14, // KURANGI dari 16 ke 14
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Flexible(
                        // UBAH Text menjadi Flexible
                        child: Text(
                          product.description,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 11, // KURANGI dari 12 ke 11
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star,
                              color: Colors.amber, size: 14), // KURANGI size
                          SizedBox(width: 4),
                          Text(
                            product.rating.toString(),
                            style: TextStyle(fontSize: 11), // KURANGI size
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        product.price,
                        style: TextStyle(
                          fontSize: 13, // KURANGI dari 14 ke 13
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 32, // BATASI tinggi button
                              child: ElevatedButton(
                                onPressed: () =>
                                    controller.consultProduct(product.id),
                                child: FittedBox(
                                  // TAMBAHKAN FittedBox untuk menyesuaikan text
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Konsultasi',
                                    style: TextStyle(
                                        fontSize: 10), // KURANGI size text
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4), // KURANGI padding
                                  minimumSize:
                                      Size(0, 32), // BATASI minimum size
                                  tapTargetSize: MaterialTapTargetSize
                                      .shrinkWrap, // KURANGI tap target
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          SizedBox(
                            width: 32,
                            height: 32,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () =>
                                    controller.toggleWishlist(product.id),
                                customBorder: CircleBorder(),
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Obx(() {
                                    final isAnimating =
                                        controller.animatingWishlist.value ==
                                            product.id;
                                    final isWishlist = product.isWishlist;

                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        if (isAnimating && isWishlist) ...[
                                          for (int i = 0; i < 5; i++)
                                            TweenAnimationBuilder<double>(
                                              tween:
                                                  Tween(begin: 0.0, end: 1.0),
                                              duration:
                                                  Duration(milliseconds: 800),
                                              builder: (context, value, child) {
                                                return Opacity(
                                                  opacity: (1 - value),
                                                  child: Transform.scale(
                                                    scale: value * 2,
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: Colors.red
                                                          .withOpacity(0.3),
                                                      size: 18,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                        ],
                                        AnimatedScale(
                                          scale: isWishlist ? 1.2 : 1.0,
                                          duration: Duration(milliseconds: 200),
                                          child: AnimatedRotation(
                                            turns: isWishlist ? 1 / 8 : 0,
                                            duration:
                                                Duration(milliseconds: 200),
                                            child: Icon(
                                              isWishlist
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: isWishlist
                                                  ? Colors.red
                                                  : Colors.grey[400],
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductGrid() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Semua Produk',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Obx(() => GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.75,
                ),
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  var product = controller.filteredProducts[index];
                  return _buildProductCard(product);
                },
              )),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () => Get.toNamed('/product-detail', arguments: product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Icon(Icons.image, size: 40, color: Colors.grey[600]),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      product.price,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 14),
                        SizedBox(width: 3),
                        Text(
                          product.rating.toString(),
                          style: TextStyle(fontSize: 11),
                        ),
                        Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => controller.toggleWishlist(product.id),
                            customBorder: CircleBorder(),
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Obx(() {
                                final isAnimating =
                                    controller.animatingWishlist.value ==
                                        product.id;
                                final isWishlist = product.isWishlist;

                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    if (isAnimating && isWishlist) ...[
                                      for (int i = 0; i < 5; i++)
                                        TweenAnimationBuilder<double>(
                                          tween: Tween(begin: 0.0, end: 1.0),
                                          duration: Duration(milliseconds: 800),
                                          builder: (context, value, child) {
                                            return Opacity(
                                              opacity: (1 - value),
                                              child: Transform.scale(
                                                scale: value * 2,
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: Colors.red
                                                      .withOpacity(0.3),
                                                  size: 18,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                    ],
                                    AnimatedScale(
                                      scale: isWishlist ? 1.2 : 1.0,
                                      duration: Duration(milliseconds: 200),
                                      child: AnimatedRotation(
                                        turns: isWishlist ? 1 / 8 : 0,
                                        duration: Duration(milliseconds: 200),
                                        child: Icon(
                                          isWishlist
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isWishlist
                                              ? Colors.red
                                              : Colors.grey[400],
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Artikel Terbaru',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => Get.toNamed('/articles'),
                child: Text('Lihat Semua'),
              ),
            ],
          ),
          SizedBox(height: 15),
          Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.articles.length,
                itemBuilder: (context, index) {
                  var article = controller.articles[index];
                  return _buildArticleCard(article);
                },
              )),
        ],
      ),
    );
  }

  Widget _buildArticleCard(Article article) {
    return GestureDetector(
      onTap: () => Get.toNamed('/article-detail', arguments: article),
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
              child: Container(
                width: 100,
                height: 80,
                color: Colors.grey[300],
                child: Icon(Icons.article, color: Colors.grey[600]),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      article.excerpt,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${article.publishedAt.day}/${article.publishedAt.month}/${article.publishedAt.year}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
