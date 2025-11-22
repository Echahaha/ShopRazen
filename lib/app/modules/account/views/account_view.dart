import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/account_controller.dart';

// Model untuk menu item
class MenuItem {
  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback onTap;

  MenuItem({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
  });
}

class AccountView extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      init: AccountController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(controller),
                  SizedBox(height: 20),
                  _buildMenuSection(
                    title: 'Akun',
                    items: [
                      MenuItem(
                        icon: Icons.person_outline,
                        title: 'Edit Profile',
                        onTap: controller.navigateToEditProfile,
                      ),
                      MenuItem(
                        icon: Icons.lock_outline,
                        title: 'Ubah Password',
                        onTap: controller.navigateToChangePassword,
                      ),
                      MenuItem(
                        icon: Icons.location_on_outlined,
                        title: 'Alamat',
                        onTap: controller.navigateToAddresses,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildMenuSection(
                    title: 'Aktivitas',
                    items: [
                      MenuItem(
                        icon: Icons.favorite_outline,
                        title: 'Wishlist',
                        trailing: '3',
                        onTap: controller.navigateToWishlist,
                      ),
                      MenuItem(
                        icon: Icons.history,
                        title: 'Riwayat Transaksi',
                        onTap: controller.navigateToTransactionHistory,
                      ),
                      MenuItem(
                        icon: Icons.rate_review_outlined,
                        title: 'Ulasan Saya',
                        onTap: controller.navigateToMyReviews,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildMenuSection(
                    title: 'Lainnya',
                    items: [
                      MenuItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notifikasi',
                        trailing: '5',
                        onTap: controller.navigateToNotifications,
                      ),
                      MenuItem(
                        icon: Icons.help_outline,
                        title: 'Bantuan',
                        onTap: controller.navigateToHelp,
                      ),
                      MenuItem(
                        icon: Icons.info_outline,
                        title: 'Tentang Razen',
                        onTap: controller.navigateToAbout,
                      ),
                      MenuItem(
                        icon: Icons.privacy_tip_outlined,
                        title: 'Kebijakan Privasi',
                        onTap: controller.navigateToPrivacyPolicy,
                      ),
                      MenuItem(
                        icon: Icons.description_outlined,
                        title: 'Syarat & Ketentuan',
                        onTap: controller.navigateToTerms,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildLogoutButton(controller),
                  SizedBox(height: 20),
                  _buildVersion(),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(AccountController controller) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[600]!, Colors.blue[800]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.blue[700],
              ),
            ),
            SizedBox(height: 15),
            Obx(() => Text(
              controller.userName.value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
            SizedBox(height: 5),
            Obx(() => Text(
              controller.userEmail.value,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            )),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() => _buildStatItem('Pesanan', controller.totalOrders.value.toString())),
                Container(width: 1, height: 30, color: Colors.white30),
                Obx(() => _buildStatItem('Wishlist', controller.totalWishlist.value.toString())),
                Container(width: 1, height: 30, color: Colors.white30),
                Obx(() => _buildStatItem('Ulasan', controller.totalReviews.value.toString())),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection({required String title, required List<MenuItem> items}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
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
          Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          ...items.map((item) => _buildMenuItem(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    return InkWell(
      onTap: item.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                item.icon,
                size: 20,
                color: Colors.blue[700],
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[800],
                ),
              ),
            ),
            if (item.trailing != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item.trailing!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(AccountController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: controller.logout,
          icon: Icon(Icons.logout),
          label: Text('Logout'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            side: BorderSide(color: Colors.red),
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVersion() {
    return Text(
      'Version 1.0.0',
      style: TextStyle(
        color: Colors.grey[500],
        fontSize: 12,
      ),
    );
  }
}