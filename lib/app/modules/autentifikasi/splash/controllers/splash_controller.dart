import 'package:get/get.dart';
import 'package:shoprazen/app/modules/autentifikasi/onboarding/views/onboarding_view.dart';
import 'package:shoprazen/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print('=== SPLASH CONTROLLER DEBUG ===');
    print('onInit() called');
    print('Current route: ${Get.currentRoute}');
    _debugAndNavigate();
  }

  @override
  void onReady() {
    super.onReady();
    print('onReady() called');
    print('Widget sudah ready, mencoba navigasi...');
  }

  void _debugAndNavigate() async {
    print('Starting debug navigation...');
    
    // Print semua routes yang tersedia
    print('Available routes:');
    AppPages.routes.forEach((route) {
      print('  - ${route.name}');
    });
    
    print('Target route: ${Routes.ONBOARDING}');
    print('Waiting 3 seconds...');
    
    // Countdown untuk debug
    for (int i = 3; i > 0; i--) {
      print('Countdown: $i');
      await Future.delayed(Duration(seconds: 1));
    }
    
    print('Attempting navigation now...');
    
    try {
      // Coba beberapa metode navigasi
      print('Method 1: Get.offAllNamed(Routes.ONBOARDING)');
      Get.offAllNamed(Routes.ONBOARDING);
      
      // Verifikasi setelah 100ms
      await Future.delayed(Duration(milliseconds: 100));
      print('After navigation - Current route: ${Get.currentRoute}');
      
    } catch (e) {
      print('Method 1 FAILED: $e');
      
      try {
        print('Method 2: Get.offAllNamed("/onboarding")');
        Get.offAllNamed('/onboarding');
        
      } catch (e2) {
        print('Method 2 FAILED: $e2');
        
        try {
          print('Method 3: Get.offAll()');
          Get.offAll(() => OnboardingView());
          
        } catch (e3) {
          print('Method 3 FAILED: $e3');
          print('ALL METHODS FAILED - CHECK ROUTES CONFIGURATION');
        }
      }
    }
  }
}