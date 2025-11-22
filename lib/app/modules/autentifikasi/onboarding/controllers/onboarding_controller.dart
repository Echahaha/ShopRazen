import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shoprazen/app/routes/app_pages.dart';

class OnboardingController extends GetxController {
  var pageIndex = 0.obs;
  PageController pageController = PageController();

  void nextPage(int totalPages) {
    if (pageIndex.value < totalPages - 1) {
      pageIndex.value++;
      pageController.animateToPage(
        pageIndex.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      skipToLogin();
    }
  }

  void skipToLogin() {
    // Gunakan Routes.LOGIN bukan hardcoded '/login'
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}