import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  final List<Map<String, dynamic>> slides = [
    {
      'title': 'Selamat Datang',
      'desc': 'Aplikasi Shop Razen membantu belanja Anda lebih mudah dan menyenangkan setiap hari.',
      'icon': Icons.shopping_cart_rounded,
      'color': Color(0xFF2196F3),
      'gradient': [Color(0xFF2196F3), Color(0xFF1976D2)],
    },
    {
      'title': 'Produk Lengkap',
      'desc': 'Temukan berbagai produk kebutuhan Anda dengan mudah dan harga terjangkau.',
      'icon': Icons.inventory_2_rounded,
      'color': Color(0xFF4CAF50),
      'gradient': [Color(0xFF4CAF50), Color(0xFF388E3C)],
    },
    {
      'title': 'Transaksi Aman',
      'desc': 'Belanja dengan sistem pembayaran yang aman, cepat, dan terpercaya.',
      'icon': Icons.security_rounded,
      'color': Color(0xFFFF9800),
      'gradient': [Color(0xFFFF9800), Color(0xFFF57C00)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF5F7FA),
              Color(0xFFC3CFE2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button dengan styling yang lebih baik
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // PageView dengan animasi yang lebih smooth
              Expanded(
                flex: 4,
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: slides.length,
                  onPageChanged: (index) => controller.pageIndex.value = index,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon dengan gradient dan shadow
                          TweenAnimationBuilder<double>(
                            duration: Duration(milliseconds: 800),
                            tween: Tween(begin: 0.0, end: 1.0),
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: 0.8 + (0.2 * value),
                                child: Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: slides[index]['gradient'],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: slides[index]['color'].withOpacity(0.3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    slides[index]['icon'],
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                          
                          SizedBox(height: 50),
                          
                          // Title dengan animasi fade
                          TweenAnimationBuilder<double>(
                            duration: Duration(milliseconds: 600),
                            tween: Tween(begin: 0.0, end: 1.0),
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, 20 * (1 - value)),
                                  child: Text(
                                    slides[index]['title']!,
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2C3E50),
                                      letterSpacing: 0.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                          ),
                          
                          SizedBox(height: 24),
                          
                          // Description dengan animasi
                          TweenAnimationBuilder<double>(
                            duration: Duration(milliseconds: 800),
                            tween: Tween(begin: 0.0, end: 1.0),
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, 30 * (1 - value)),
                                  child: Text(
                                    slides[index]['desc']!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF7F8C8D),
                                      height: 1.6,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              // Page indicators dengan animasi yang lebih halus
              Obx(() => Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    slides.length,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      width: controller.pageIndex.value == index ? 30 : 12,
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: controller.pageIndex.value == index
                            ? LinearGradient(
                                colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                              )
                            : null,
                        color: controller.pageIndex.value == index
                            ? null
                            : Colors.grey[400],
                        boxShadow: controller.pageIndex.value == index
                            ? [
                                BoxShadow(
                                  color: Color(0xFF2196F3).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                    ),
                  ),
                ),
              )),
              
              // Action buttons dengan styling yang lebih modern
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Obx(() => controller.pageIndex.value == slides.length - 1
                    ? Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF2196F3).withOpacity(0.3),
                              blurRadius: 15,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: controller.skipToLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Mulai Belanja Sekarang',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: controller.skipToLogin,
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  'Lewati',
                                  style: TextStyle(
                                    color: Color(0xFF7F8C8D),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF2196F3).withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () => controller.nextPage(slides.length),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Lanjut',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                ),
              ),
              
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}