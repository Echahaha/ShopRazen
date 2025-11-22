import 'package:get/get.dart';

import '../../orders/controllers/orders_controller.dart';

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final DateTime date;
  bool read;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    this.read = false,
  });
}

class NotificationsController extends GetxController {
  final notifications = <NotificationItem>[].obs;

  // Keep last known order statuses to detect changes
  final Map<String, String> _lastOrderStatus = {};

  @override
  void onInit() {
    super.onInit();
    // Try to subscribe to OrdersController if available
    OrdersController? ordersController;
    if (Get.isRegistered<OrdersController>()) {
      ordersController = Get.find<OrdersController>();
    }
    if (ordersController != null) {
      // Handle current orders (treat existing orders as initial state)
      _handleOrderUpdates(ordersController.orders);

      // Listen for changes in orders list
      ever<List<Order>>(ordersController.orders, (list) {
        _handleOrderUpdates(list);
      });
    }
  }

  void _handleOrderUpdates(List<Order> orders) {
    try {
      for (var o in orders) {
        final prev = _lastOrderStatus[o.id];
        if (prev == null) {
          // new order
          _lastOrderStatus[o.id] = o.status;
          if (o.status.toLowerCase().contains('selesai')) {
            add(NotificationItem(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: 'Pesanan Selesai',
              body: 'Pesanan ${o.id} telah selesai.',
              date: DateTime.now(),
            ));
          }
          continue;
        }

        if (prev != o.status) {
          _lastOrderStatus[o.id] = o.status;
          // Create notification about progress change
          add(NotificationItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: 'Update Pesanan ${o.id}',
            body: 'Status pesanan berubah: ${prev} → ${o.status}',
            date: DateTime.now(),
          ));
        }
      }
    } catch (e, st) {
      print('Error in NotificationsController._handleOrderUpdates: $e');
      print(st);
    }
  }

  void add(NotificationItem n) {
    notifications.insert(0, n);
  }

  void markRead(String id) {
    final idx = notifications.indexWhere((e) => e.id == id);
    if (idx != -1) {
      notifications[idx].read = true;
      notifications.refresh();
    }
  }

  void markAllRead() {
    for (var n in notifications) n.read = true;
    notifications.refresh();
  }

  void remove(String id) {
    notifications.removeWhere((e) => e.id == id);
  }
}
