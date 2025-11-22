import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../notifications/controllers/notifications_controller.dart';

// Model Order
class Order {
  final String id;
  final String productName;
  final String price;
  String status;
  final DateTime orderDate;
  final String? trackingNumber;
  Color statusColor;

  Order({
    required this.id,
    required this.productName,
    required this.price,
    required this.status,
    required this.orderDate,
    this.trackingNumber,
    required this.statusColor,
  });
}

class OrdersController extends GetxController {
  var selectedTab = 0.obs;
  var orders = <Order>[].obs;
  var filteredOrders = <Order>[].obs;

  final List<String> tabs = [
    'Semua',
    'Proses',
    'Selesai',
    'Dibatalkan'
  ];

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  void loadOrders() {
    orders.value = [
      Order(
        id: 'ORD001',
        productName: 'Website Development - Toko Online',
        price: 'Rp 5.000.000',
        status: 'Dalam Proses',
        orderDate: DateTime.now().subtract(Duration(days: 2)),
        statusColor: Colors.blue,
      ),
      Order(
        id: 'ORD002',
        productName: 'Mobile App Development',
        price: 'Rp 8.000.000',
        status: 'Sedang Dikerjakan',
        orderDate: DateTime.now().subtract(Duration(days: 7)),
        trackingNumber: 'TRK123456',
        statusColor: Colors.orange,
      ),
      Order(
        id: 'ORD003',
        productName: 'Video Production - Company Profile',
        price: 'Rp 3.500.000',
        status: 'Selesai',
        orderDate: DateTime.now().subtract(Duration(days: 30)),
        statusColor: Colors.green,
      ),
      Order(
        id: 'ORD004',
        productName: 'UI/UX Design',
        price: 'Rp 2.000.000',
        status: 'Dibatalkan',
        orderDate: DateTime.now().subtract(Duration(days: 45)),
        statusColor: Colors.red,
      ),
    ];
    filterOrders();
  }

  void changeTab(int index) {
    selectedTab.value = index;
    filterOrders();
  }

  void filterOrders() {
    if (selectedTab.value == 0) {
      filteredOrders.value = orders;
    } else {
      String filterStatus = tabs[selectedTab.value];
      filteredOrders.value = orders.where((order) {
        if (filterStatus == 'Proses') {
          return order.status.contains('Proses') || order.status.contains('Dikerjakan');
        } else if (filterStatus == 'Selesai') {
          return order.status == 'Selesai';
        } else if (filterStatus == 'Dibatalkan') {
          return order.status == 'Dibatalkan';
        }
        return true;
      }).toList();
    }
  }

  void cancelOrder(String orderId) {
    Get.dialog(
      AlertDialog(
        title: Text('Batalkan Pesanan'),
        content: Text('Apakah Anda yakin ingin membatalkan pesanan ini?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Tidak'),
          ),
          ElevatedButton(
            onPressed: () {
              // Update order status and notify
              final idx = orders.indexWhere((o) => o.id == orderId);
              if (idx != -1) {
                orders[idx].status = 'Dibatalkan';
                orders[idx].statusColor = Colors.red;
                filterOrders();

                // If NotificationsController exists, add a notification
                if (Get.isRegistered<NotificationsController>()) {
                  final notif = Get.find<NotificationsController>();
                  notif.add(NotificationItem(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: 'Pesanan Dibatalkan',
                    body: 'Pesanan $orderId berhasil dibatalkan.',
                    date: DateTime.now(),
                  ));
                }
              }

              Get.back();
              Get.snackbar(
                'Berhasil',
                'Pesanan berhasil dibatalkan',
                backgroundColor: Colors.orange,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Text('Ya, Batalkan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// Update an order status programmatically and create a notification about it.
  void updateOrderStatus(String orderId, String newStatus, {String? trackingNumber}) {
    try {
      final idx = orders.indexWhere((o) => o.id == orderId);
      if (idx == -1) return;
      final prev = orders[idx].status;
      orders[idx].status = newStatus;
    // adjust color simply by keywords
    if (newStatus.toLowerCase().contains('selesai')) {
      orders[idx].statusColor = Colors.green;
    } else if (newStatus.toLowerCase().contains('kirim') || newStatus.toLowerCase().contains('dikirim')) {
      orders[idx].statusColor = Colors.green[700]!;
    } else if (newStatus.toLowerCase().contains('proses') || newStatus.toLowerCase().contains('dikerjakan')) {
      orders[idx].statusColor = Colors.blue;
    }
    if (trackingNumber != null) {
      // Unfortunately Order.trackingNumber is final; to keep it simple we won't update it here.
    }
      filterOrders();

      if (Get.isRegistered<NotificationsController>()) {
        final notif = Get.find<NotificationsController>();
        notif.add(NotificationItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: 'Update Pesanan $orderId',
          body: 'Status pesanan berubah: $prev → $newStatus',
          date: DateTime.now(),
        ));
      }
    } catch (e, st) {
      print('Error in updateOrderStatus: $e');
      print(st);
      try {
        Get.snackbar('Error', 'Gagal memperbarui status pesanan: $e', snackPosition: SnackPosition.BOTTOM);
      } catch (_) {}
    }
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