import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends StatelessWidget {
  NotificationsView({Key? key}) : super(key: key);

  final NotificationsController controller = Get.isRegistered<NotificationsController>()
      ? Get.find<NotificationsController>()
      : Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Enhanced header with gradient
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[700]!, Colors.blue[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: kToolbarHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Get.back(),
                            tooltip: 'Kembali',
                          ),
                          Icon(Icons.notifications_active, 
                            color: Colors.white, 
                            size: 24
                          ),
                          SizedBox(width: 12),
                          const Text(
                            'Notifikasi',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Obx(() => controller.notifications.isNotEmpty
                          ? TextButton.icon(
                              onPressed: controller.markAllRead,
                              icon: Icon(Icons.done_all, 
                                color: Colors.white, 
                                size: 18
                              ),
                              label: const Text(
                                'Tandai dibaca',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : SizedBox()),
                    ],
                  ),
                ),
                // Notification count indicator
                Obx(() {
                  final unreadCount = controller.notifications
                      .where((n) => !n.read)
                      .length;
                  if (unreadCount > 0) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      color: Colors.white.withOpacity(0.2),
                      child: Text(
                        '$unreadCount notifikasi belum dibaca',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    );
                  }
                  return SizedBox();
                }),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.notifications.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.notifications_none_rounded,
                          size: 80,
                          color: Colors.blue[300],
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Belum ada notifikasi',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Notifikasi Anda akan muncul di sini',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.all(16),
                itemCount: controller.notifications.length,
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final n = controller.notifications[index];
                  final isUnread = !n.read;
                  
                  return Dismissible(
                    key: ValueKey(n.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => controller.remove(n.id),
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_outline, 
                            color: Colors.white, 
                            size: 28
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Hapus',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isUnread 
                              ? Colors.blue.withOpacity(0.3) 
                              : Colors.grey.withOpacity(0.1),
                          width: isUnread ? 2 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isUnread
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.grey.withOpacity(0.05),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            controller.markRead(n.id);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Icon container
                                Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isUnread 
                                        ? Colors.blue.withOpacity(0.1)
                                        : Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.notifications_rounded,
                                    color: isUnread 
                                        ? Colors.blue[700] 
                                        : Colors.grey[600],
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: 16),
                                // Content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              n.title,
                                              style: TextStyle(
                                                fontWeight: isUnread 
                                                    ? FontWeight.w700 
                                                    : FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.grey[900],
                                              ),
                                            ),
                                          ),
                                          if (isUnread)
                                            Container(
                                              width: 10,
                                              height: 10,
                                              margin: EdgeInsets.only(left: 8),
                                              decoration: BoxDecoration(
                                                color: Colors.blue[700],
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        n.body,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                          height: 1.4,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_rounded,
                                            size: 14,
                                            color: Colors.grey[500],
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            _formatDate(n.date),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Baru saja';
        }
        return '${difference.inMinutes} menit yang lalu';
      }
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inDays == 1) {
      return 'Kemarin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari yang lalu';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}