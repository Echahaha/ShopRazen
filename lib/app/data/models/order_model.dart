import 'dart:typed_data';

enum OrderStatus {
  consultation,
  waitingPayment,
  waitingContract,
  processing,
  completed,
  cancelled,
}

class OrderProgress {
  final String title;
  final String description;
  final DateTime timestamp;
  final bool isCompleted;

  OrderProgress({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.isCompleted,
  });

  // Konversi dari JSON
  factory OrderProgress.fromJson(Map<String, dynamic> json) {
    return OrderProgress(
      title: json['title'] as String,
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isCompleted: json['isCompleted'] as bool,
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }
}

class OrderModel {
  final String id;
  final String productName;
  final String price;
  final OrderStatus status;
  final DateTime createdAt;
  final List<OrderProgress> progress;
  final String? consultationNotes;
  final String? paymentProof;
  final Uint8List? signatureData;
  final DateTime? contractSignedAt;

  OrderModel({
    required this.id,
    required this.productName,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.progress,
    this.consultationNotes,
    this.paymentProof,
    this.signatureData,
    this.contractSignedAt,
  });

  // Constructor untuk membuat salinan dengan perubahan
  OrderModel copyWith({
    String? id,
    String? productName,
    String? price,
    OrderStatus? status,
    DateTime? createdAt,
    List<OrderProgress>? progress,
    String? consultationNotes,
    String? paymentProof,
    Uint8List? signatureData,
    DateTime? contractSignedAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      progress: progress ?? this.progress,
      consultationNotes: consultationNotes ?? this.consultationNotes,
      paymentProof: paymentProof ?? this.paymentProof,
      signatureData: signatureData ?? this.signatureData,
      contractSignedAt: contractSignedAt ?? this.contractSignedAt,
    );
  }

  // Konversi dari JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      productName: json['productName'] as String,
      price: json['price'] as String,
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == 'OrderStatus.${json['status']}',
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      progress: (json['progress'] as List<dynamic>)
          .map((e) => OrderProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
      consultationNotes: json['consultationNotes'] as String?,
      paymentProof: json['paymentProof'] as String?,
      signatureData: json['signatureData'] != null
          ? Uint8List.fromList(List<int>.from(json['signatureData']))
          : null,
      contractSignedAt: json['contractSignedAt'] != null
          ? DateTime.parse(json['contractSignedAt'] as String)
          : null,
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'price': price,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'progress': progress.map((e) => e.toJson()).toList(),
      'consultationNotes': consultationNotes,
      'paymentProof': paymentProof,
      'signatureData': signatureData?.toList(),
      'contractSignedAt': contractSignedAt?.toIso8601String(),
    };
  }
}