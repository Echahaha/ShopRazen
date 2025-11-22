import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  // Admin Info
  var adminName = 'Admin User'.obs;
  var adminDivision = 'Digital Marketing'.obs;
  
  // Statistics
  var newOrdersCount = 12.obs;
  var todaySales = 'Rp 5.250.000'.obs;
  var activeProductsCount = 45.obs;
  var pendingOrdersCount = 8.obs;
  
  // Product Summary
  var totalProducts = 45.obs;
  var inStockProducts = 38.obs;
  var lowStockProducts = 5.obs;
  var outOfStockProducts = 2.obs;
  
  // Recent Orders
  var recentOrders = <AdminOrder>[].obs;
  
  // Sales Data for Chart
  var salesData = <Map<String, dynamic>>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }
  
  void loadDashboardData() {
    loadAdminInfo();
    loadStatistics();
    loadRecentOrders();
    loadSalesData();
  }
  
  void loadAdminInfo() {
    // TODO: Load from API or local storage
    // Simulate data
    adminName.value = 'Budi Santoso';
    adminDivision.value = 'Digital Marketing';
  }
  
  void loadStatistics() {
    // TODO: Load from API
    // Simulate data
    newOrdersCount.value = 12;
    todaySales.value = 'Rp 5.250.000';
    activeProductsCount.value = 45;
    pendingOrdersCount.value = 8;
    
    // Product summary
    totalProducts.value = 45;
    inStockProducts.value = 38;
    lowStockProducts.value = 5;
    outOfStockProducts.value = 2;
  }
  
  void loadRecentOrders() {
    // TODO: Load from API
    // Simulate data
    recentOrders.value = [
      AdminOrder(
        id: '001234',
        customerName: 'Ahmad Rizki',
        productName: 'Paket Digital Marketing Premium',
        totalPrice: 'Rp 2.500.000',
        status: 'Menunggu Pembayaran',
        orderDate: '20 Okt 2025',
      ),
      AdminOrder(
        id: '001235',
        customerName: 'Siti Nurhaliza',
        productName: 'Social Media Management',
        totalPrice: 'Rp 1.800.000',
        status: 'Diproses',
        orderDate: '20 Okt 2025',
      ),
      AdminOrder(
        id: '001236',
        customerName: 'Budi Hartono',
        productName: 'SEO Optimization',
        totalPrice: 'Rp 3.200.000',
        status: 'Diproses',
        orderDate: '19 Okt 2025',
      ),
      AdminOrder(
        id: '001237',
        customerName: 'Dewi Lestari',
        productName: 'Content Creation',
        totalPrice: 'Rp 1.500.000',
        status: 'Selesai',
        orderDate: '19 Okt 2025',
      ),
      AdminOrder(
        id: '001238',
        customerName: 'Andi Wijaya',
        productName: 'Instagram Ads Campaign',
        totalPrice: 'Rp 2.000.000',
        status: 'Menunggu Pembayaran',
        orderDate: '18 Okt 2025',
      ),
    ];
  }
  
  void loadSalesData() {
    // TODO: Load from API
    // Simulate weekly sales data
    salesData.value = [
      {'day': 'Sen', 'current': 75.0, 'previous': 60.0},
      {'day': 'Sel', 'current': 85.0, 'previous': 70.0},
      {'day': 'Rab', 'current': 65.0, 'previous': 80.0},
      {'day': 'Kam', 'current': 90.0, 'previous': 75.0},
      {'day': 'Jum', 'current': 95.0, 'previous': 85.0},
      {'day': 'Sab', 'current': 80.0, 'previous': 90.0},
      {'day': 'Min', 'current': 70.0, 'previous': 65.0},
    ];
  }
  
  // Actions
  void navigateToAddProduct() {
    Get.toNamed('/admin/add-product');
  }
  
  void navigateToManageProducts() {
    Get.toNamed('/admin/manage-products');
  }
  
  void navigateToOrders() {
    Get.toNamed('/admin/orders');
  }
  
  void navigateToReports() {
    Get.toNamed('/admin/reports');
  }
  
  void updateOrderStatus(String orderId, String newStatus) {
    // TODO: Update via API
    int index = recentOrders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      // Create new order with updated status
      var oldOrder = recentOrders[index];
      recentOrders[index] = AdminOrder(
        id: oldOrder.id,
        customerName: oldOrder.customerName,
        productName: oldOrder.productName,
        totalPrice: oldOrder.totalPrice,
        status: newStatus,
        orderDate: oldOrder.orderDate,
      );
      recentOrders.refresh();
      
      Get.snackbar(
        'Berhasil',
        'Status pesanan berhasil diperbarui',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor,
        colorText: Get.theme.colorScheme.onPrimary,
      );
    }
  }
  
  void viewOrderDetail(AdminOrder order) {
    Get.toNamed('/admin/order-detail', arguments: order);
  }
}

class AdminOrder {
  final String id;
  final String customerName;
  final String productName;
  final String totalPrice;
  final String status;
  final String orderDate;

  AdminOrder({
    required this.id,
    required this.customerName,
    required this.productName,
    required this.totalPrice,
    required this.status,
    required this.orderDate,
  });
}