import 'package:get/get.dart';

import '../controllers/main_navigation_controller.dart';
import '../../orders/controllers/orders_controller.dart';

class MainNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainNavigationController>(
      () => MainNavigationController(),
    );
    // Ensure OrdersController is available as soon as MainNavigation is loaded
    Get.lazyPut<OrdersController>(() => OrdersController());
  }
}
